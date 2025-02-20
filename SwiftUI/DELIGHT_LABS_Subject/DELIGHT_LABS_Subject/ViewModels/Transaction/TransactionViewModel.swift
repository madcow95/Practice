import SwiftUI
import Combine

final class TransactionViewModel: ObservableObject {
    // MARK: Binding Data
    @Published var isLoading = false
    @Published var selectedGraphDateType: GraphDateSelectionType = .week
    @Published var selectedTransactionType: RecentTransactionFilterType = .all
    @Published var chartDisplayDate: Date = Date()
    @Published var groupedTransactionsByDate: [String: [Transaction]] = [:]
    @Published var recentTransactionsListData: [Transaction] = []
    @Published var lineChartDatas: [(category: String, data: [(fullDate: String, date: String, amount: Double)])] = []
    @Published var chartSelectedDate: String? = nil
    @Published var chartSelectedTransaction: [(fullDate: String, date: String, amount: Double)]? = nil
    @Published var showToast: Bool = false
    @Published var newTransaction: Transaction?
    
    private var currentDataCase: DataCase {
        return selectedGraphDateType == .week ? .last7Days : .last30Days
    }
    private let dataService: DataService
    private var cancellables = Set<AnyCancellable>()
    
    init(dataService: DataService) {
        self.dataService = dataService
        loadTransactions()
        reloadPeriodDate()
    }
    
    // MARK: JSON Data -> Transaction Data로 변환
    func loadTransactions() {
        dataService.fetchData()
            .receive(on: DispatchQueue.global())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("에러 발생: \(error.localizedDescription)")
                case .finished:
                    print("데이터 로드 완료")
                }
            }, receiveValue: { [weak self] transactions in
                guard let self = self else { return }
                
                self.isLoading = true
                
                let todayString = Calendar.current.startOfDay(for: Date()).dateToString(includeDay: .day)
                let groupedTransactions = Dictionary(grouping: transactions.filter { transaction in
                    let transactionDate = Calendar.current.startOfDay(for: transaction.date).dateToString(includeDay: .day)

                    return transactionDate <= todayString
                }) { transaction in
                    return Calendar.current.startOfDay(for: transaction.date).dateToString(includeDay: .day)
                }
                
                DispatchQueue.main.async {
                    self.groupedTransactionsByDate = groupedTransactions
                    self.isLoading = false
                    self.configureTransactionDatas(dataCase: .latest20Transactions)
                    self.configureTransactionDatas(dataCase: .last7Days)
                }
            })
            .store(in: &cancellables)
    }
    
    func configureTransactionDatas(dataCase: DataCase) {
        if [.latest20Transactions, .latest10Income, .latest10Expense].contains(dataCase) {
            // MARK: Recent Transaction Data
            recentTransactionsListData = configureRecentTransactionList(dataCase: dataCase)
        } else {
            // MARK: Chart Graph Data
            lineChartDatas = configureChartTransactionDatas(dataCase: dataCase)
        }
    }
    
    private func configureRecentTransactionList(dataCase: DataCase) -> [Transaction] {
        let sortedDates = groupedTransactionsByDate.keys.sorted { $0 > $1 }
        var recentTransactionsList: [Transaction] = []

        for date in sortedDates {
            if let transactions = groupedTransactionsByDate[date] {
                recentTransactionsList.append(contentsOf: transactions)
            }
            
            if recentTransactionsList.count >= 20 {
                break
            }
        }

        let sortedTransactions = recentTransactionsList.sorted { $0.date > $1.date }

        switch dataCase {
        case .latest20Transactions:
            return Array(sortedTransactions.prefix(20))
        case .latest10Income:
            return Array(sortedTransactions.filter { $0.amountDouble > 0 }.prefix(10))
        case .latest10Expense:
            return Array(sortedTransactions.filter { $0.amountDouble < 0 }.prefix(10))
        default:
            return []
        }
    }
    
    private func configureChartTransactionDatas(dataCase: DataCase) -> [(category: String, data: [(fullDate: String, date: String, amount: Double)])] {
        let today = Date().dateToString(includeDay: .day)
        let calendar = Calendar.current
        let daysAgo = dataCase == .last7Days ? -6 : -30
        // 오늘을 기준으로 7, 30일 전 날짜
        let pastDays = calendar.date(byAdding: .day, value: daysAgo, to: Date())?.dateToString(includeDay: .day) ?? ""

        var incomeTotalData: [(fullDate: String, date: String, amount: Double)] = []
        var expenseTotalData: [(fullDate: String, date: String, amount: Double)] = []

        for (dateString, transactions) in groupedTransactionsByDate where dateString >= pastDays && dateString <= today {
            let incomeTotal = transactions.filter { $0.amountDouble > 0 }
                .reduce(0) { $0 + $1.amountDouble }
                .getTwoDecimal

            let expenseTotal = transactions.filter { $0.amountDouble < 0 }
                .reduce(0) { $0 + $1.amountDouble }
                .getTwoDecimal

            incomeTotalData.append((dateString, String(dateString.dropFirst(5)), incomeTotal))
            expenseTotalData.append((dateString, String(dateString.dropFirst(5)), expenseTotal))
        }

        return [
            (category: "Income", data: incomeTotalData.sorted { $0.date < $1.date }),
            (category: "Expense", data: expenseTotalData.sorted { $0.date < $1.date })
        ]
    }
    
    // MARK: Week / Month 선택 변경 후
    func reloadPeriodDate() {
        let calendar = Calendar.current
        let daysToSubtract = selectedGraphDateType == .week ? -6 : -30
        guard let targetDate = calendar.date(byAdding: .day, value: daysToSubtract, to: Date()) else { return }
        
        chartDisplayDate = targetDate
        configureTransactionDatas(dataCase: currentDataCase)
    }
    
    // MARK: Transaction 추가 후
    func addTransaction(transaction: Transaction) {
        newTransaction = transaction
        let date = transaction.date.dateToString(includeDay: .day)

        groupedTransactionsByDate[date, default: []].append(transaction)

        configureTransactionDatas(dataCase: .latest20Transactions)
        configureTransactionDatas(dataCase: currentDataCase)
    }
}
