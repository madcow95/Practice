//
//  AddTransactionViewModel.swift
//  DELIGHT_LABS_Subject
//
//  Created by MadCow on 2025/2/13.
//

import Foundation
import Combine

final class AddTransactionViewModel: ObservableObject {
    @Published var selectedTransactionCase: RecentTransactionFilterType = .income
    @Published var name: String = ""
    @Published var amount: String = ""
    @Published var buttonActivate: Bool = false
    
    init() {
        $name.combineLatest($amount)
            .map { !$0.isEmpty && !$1.isEmpty }
            .assign(to: &$buttonActivate)
    }
    
    func addTransaction(completion: @escaping (Transaction) -> Void) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.locale = Locale(identifier: "ko_KR")
        
        let transaction = Transaction(amount: selectedTransactionCase == .income ? "\(amount)" : "-\(amount)",
                                      name: name,
                                      timestamp: formatter.string(from: Date()),
                                      type: "transfer")
        
        print(transaction.date.dateToString(includeDay: .time))
        
        completion(transaction)
    }
}
