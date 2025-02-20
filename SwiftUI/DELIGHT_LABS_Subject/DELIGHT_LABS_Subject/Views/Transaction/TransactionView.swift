import SwiftUI
import Charts

struct TransactionView: View {
    @StateObject private var viewModel: TransactionViewModel
    @State private var addTransactionViewPresented: Bool = false
    
    init() {
        let dataService = DataService()
        _viewModel = StateObject(wrappedValue: TransactionViewModel(dataService: dataService))
    }
    
    var body: some View {
        ZStack {
            NavigationStack {
                VStack {
                    if !viewModel.isLoading {
                        HStack {
                            CustomText(text: "Transactions",
                                       font: .largeTitle)
                            Spacer()
                        }
                        .padding()
                        ScrollView {
                            VStack(spacing: 0) {
                                HStack {
                                    VStack {
                                        VStack {
                                            DateSegmentedControlView(viewModel: self.viewModel)
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.top, 5)
                                        
                                        // MARK: Information of Income / Expense
                                        TransactionInfoView(viewModel: self.viewModel)
                                    }
                                }
                                
                                // MARK: ChartView
                                ChartView(viewModel: self.viewModel)
                                
                                HStack {
                                    CustomText(text: viewModel.chartDisplayDate.dateToString(),
                                               fontSize: 16,
                                               fontWeight: .semibold,
                                               fontColor: Color(UIColor.lightGray))
                                    Spacer()
                                    CustomText(text: Date().dateToString(),
                                               fontSize: 16,
                                               fontWeight: .semibold,
                                               fontColor: Color(UIColor.lightGray))
                                }
                                .padding()
                                .padding(.top, -5)
                                
                                HStack {
                                    CustomText(text: "Recent Transaction",
                                               fontWeight: .bold)
                                    
                                    Spacer()
                                }
                                .padding()
                                
                                TransactionTypeControlView(viewModel: self.viewModel)
                                .padding()
                                
                                // MARK: All / Income / Expense List View
                                RecentTransactionList(viewModel: viewModel)
                            }
                        }
                        .toolbar {
                            ToolbarItem(placement: .topBarTrailing) {
                                Button {
                                    self.addTransactionViewPresented = true
                                } label: {
                                    Image(systemName: "plus")
                                }
                            }
                        }
                        .sheet(isPresented: $addTransactionViewPresented) {
                            // MARK: Transaction 추가 화면
                            AddTransactionView() { transaction in
                                // MARK: 토스트 메세지 표시
                                showToastMessage()
                                
                                // MARK: Transaction 추가 후 Chart에서 선택된 항목들 초기화
                                self.viewModel.chartSelectedDate = nil
                                self.viewModel.chartSelectedTransaction = nil
                                self.viewModel.selectedGraphDateType = .week
                                self.viewModel.selectedTransactionType = .all
                                
                                viewModel.addTransaction(transaction: transaction)
                            }
                        }
                    } else {
                        VStack(spacing: 10) {
                            ProgressView()
                                .progressViewStyle(.automatic)
                            
                            CustomText(text: "JSON파일 변환 중...",
                                       font: .title3)
                        }
                        .frame(height: 161)
                    }
                }
            }
        }
        .overlay(
            Group {
                if viewModel.showToast {
                    VStack {
                        Spacer()
                        // MARK: 토스트 메시지 화면
                        ToastMessageView(viewModel: viewModel)
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                            .padding(.bottom, 50)
                    }
                    .background(.clear)
                    .animation(.easeInOut, value: viewModel.showToast)
                }
            }
        )
    }
    
    func showToastMessage() {
        withAnimation {
            viewModel.showToast = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            withAnimation {
                viewModel.showToast = false
            }
        }
    }
}

struct DateSegmentedControlView: View {
    @ObservedObject var viewModel: TransactionViewModel
    @State private var isTapDisabled = false // 버튼 연속 탭 방지

    var body: some View {
        HStack {
            ForEach(GraphDateSelectionType.allCases, id: \.self) { segment in
                CustomText(text: segment.rawValue,
                           fontSize: 16,
                           fontWeight: .bold,
                           fontColor: viewModel.selectedGraphDateType == segment ? .white : .gray)
                .frame(width: 86, height: 34)
                .background(viewModel.selectedGraphDateType == segment ? Color.primaryColor : Color.clear)
                .clipShape(Capsule())
                .onTapGesture {
                    guard !isTapDisabled else { return }
                    isTapDisabled = true
                    
                    withAnimation(.easeInOut(duration: 0.2)) {
                        viewModel.selectedGraphDateType = segment
                        viewModel.reloadPeriodDate()
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        isTapDisabled = false
                    }
                }
            }
        }
        .background(Color(UIColor.systemGray5))
        .clipShape(Capsule())
        .padding(.leading)
    }
}

struct TransactionInfoView: View {
    @ObservedObject var viewModel: TransactionViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                CustomText(text: viewModel.chartSelectedTransaction?.first?.fullDate ?? Date().dateToString(includeDay: .day),
                           fontSize: 12,
                           fontWeight: .semibold)
                Spacer()
            }
            .padding(.leading)
            .padding([.top, .bottom], -8)
            
            HStack(spacing: 20) {
                VStack {
                    HStack(spacing: 10) {
                        Rectangle()
                            .fill(Color.primaryColor)
                            .frame(width: 32, height: 5)
                        CustomText(text: "Income", fontSize: 12)
                    }
                    
                    let amount = viewModel.chartSelectedTransaction?.first?.amount ?? 0
                    let amountStr = amount.formattedSeparator()
                    CustomText(text: "+$\(amountStr)",
                               fontSize: 12,
                               fontWeight: .semibold,
                               fontColor: .primaryColor,
                               allowsTightening: true)
                    .padding(.trailing, -5)
                }
                
                VStack {
                    HStack(spacing: 15) {
                        Rectangle()
                            .fill(Color.expenseColor)
                            .frame(width: 32, height: 5)
                        CustomText(text: "Expense",
                                   fontSize: 12)
                    }
                    
                    let amount = viewModel.chartSelectedTransaction?.last?.amount ?? 0
                    let amountStr = abs(amount).formattedSeparator()
                    CustomText(text: "-$\(amountStr)",
                               fontSize: 12,
                               fontWeight: .semibold,
                               fontColor: .expenseColor,
                               allowsTightening: true)
                        .padding(.trailing, -5)
                }
                
                Spacer()
            }
            .padding()
        }
        .padding()
    }
}

struct TransactionTypeControlView: View {
    @ObservedObject var viewModel: TransactionViewModel
    @State private var isTapDisabled = false // 버튼 연속 탭 방지
    
    var body: some View {
        HStack(spacing: 25) {
            ForEach(RecentTransactionFilterType.allCases, id: \.self) { segment in
                CustomText(text: segment.rawValue,
                           fontSize: 16,
                           fontWeight: .bold,
                           fontColor: viewModel.selectedTransactionType == segment ? .primaryColor : Color(UIColor.lightGray))
                .frame(height: 24)
                .onTapGesture {
                    guard !isTapDisabled else { return }
                    isTapDisabled = true
                    
                    withAnimation(.easeInOut(duration: 0.2)) {
                        viewModel.selectedTransactionType = segment
                        var dataCase: DataCase = .latest20Transactions
                        switch viewModel.selectedTransactionType {
                        case .all:
                            dataCase = .latest20Transactions
                        case .expense:
                            dataCase = .latest10Expense
                        case .income:
                            dataCase = .latest10Income
                        }
                        viewModel.configureTransactionDatas(dataCase: dataCase)
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        isTapDisabled = false
                    }
                }
            }
            Spacer()
        }
    }
}

struct ChartView: View {
    @ObservedObject var viewModel: TransactionViewModel
    
    var body: some View {
        Chart {
            ForEach(viewModel.lineChartDatas, id: \.category) { data in
                ForEach(data.data, id: \.date) { item in
                    LineMark(
                        x: .value("Date", item.date),
                        y: .value("Amount", item.amount)
                    )
                    .foregroundStyle(by: .value("Category", data.category))
                    .symbol() {
                        ZStack {
                            Circle()
                                .fill(data.category == "Income" ? Color.primaryColor : Color.expenseColor)
                                .frame(width: item.date == viewModel.chartSelectedDate ? 15 : 5)
                                .opacity(0.8)
                        }
                    }
                    .interpolationMethod(.catmullRom)
                    .shadow(color: data.category == "Income" ? Color.primaryColor : Color.expenseColor, radius: 7, y: 7)
                }
            }
        }
        .chartForegroundStyleScale([
            "Income": Color.primaryColor,
            "Expense": Color.expenseColor
        ])
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)
        .chartLegend(.hidden)
        .chartOverlay { proxy in
            Rectangle()
                .fill(Color.clear)
                .contentShape(Rectangle())
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            let location = value.location
                            if let selectedDateStr: String = proxy.value(atX: location.x) {
                                viewModel.chartSelectedDate = selectedDateStr
                                
                                if let index = viewModel.lineChartDatas[0].data.firstIndex(where: { $0.date == selectedDateStr }) {
                                    viewModel.chartSelectedTransaction = [viewModel.lineChartDatas[0].data[index], viewModel.lineChartDatas[1].data[index]]
                                }
                            }
                        }
                        .onEnded { _ in }
                )
        }
        .frame(height: 200)
        .padding()
    }
}

struct RecentTransactionList: View {
    @ObservedObject var viewModel: TransactionViewModel
    
    var body: some View {
        ForEach(viewModel.recentTransactionsListData, id: \.timestamp) { transaction in
            VStack {
                HStack(spacing: 20) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(UIColor.systemGray5))
                        .frame(width: 50, height: 50)
                    VStack {
                        HStack {
                            CustomText(text: transaction.name,
                                       fontSize: 16,
                                       fontWeight: .semibold)
                            Spacer()
                            CustomText(text: transaction.amountStr,
                                       fontSize: 16,
                                       fontWeight: .bold,
                                       fontColor: transaction.isIncome ? Color.primaryColor : Color.expenseColor)
                        }
                        HStack {
                            CustomText(text: transaction.type,
                                       fontSize: 14,
                                       fontColor: .gray)
                            Spacer()
                            CustomText(text: transaction.date.dateToString(includeDay: .time),
                                       fontSize: 14,
                                       fontColor: .gray)
                        }
                    }
                }
                .frame(height: 51)
            }
            .padding()
        }
    }
}

struct ToastMessageView: View {
    @ObservedObject var viewModel: TransactionViewModel
    
    var body: some View {
        if let savedTransaction = viewModel.newTransaction {
            HStack {
                VStack(spacing: 10) {
                    HStack {
                        CustomText(text: savedTransaction.name,
                                   fontSize: 16,
                                   fontWeight: .semibold,
                                   fontColor: .white)
                        Spacer()
                        CustomText(text: savedTransaction.amountStr,
                                   fontSize: 16,
                                   fontWeight: .bold,
                                   fontColor: .white)
                    }
                    
                    HStack {
                        CustomText(text: savedTransaction.type,
                                   fontSize: 14,
                                   fontWeight: .semibold,
                                   fontColor: .white)
                        Spacer()
                        CustomText(text: savedTransaction.date.dateToString(includeDay: .time),
                                   fontSize: 14,
                                   fontWeight: .semibold,
                                   fontColor: .white)
                    }
                }
            }
            .padding()
            .background(savedTransaction.isIncome ? Color.primaryColor.opacity(0.8) : Color.expenseColor.opacity(0.8))
            .cornerRadius(12)
            .shadow(radius: 5)
            .padding(.horizontal, 20)
        }
    }
}
