//
//  Transaction.swift
//  DELIGHT_LABS_Subject
//
//  Created by MadCow on 2025/2/12.
//

import Foundation

struct Transaction: Codable {
    let amount: String
    let name: String
    let timestamp: String
    let type: String
    var amountDouble: Double {
        get {
            return Double(self.amount) ?? 0
        }
    }
    var isIncome: Bool {
        get {
            return amountDouble >= 0
        }
    }
    var amountStr: String {
        get {
            return self.isIncome ? "+$\(amountDouble)" : "-$\(abs(amountDouble))"
        }
    }
    var date: Date {
        get {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            formatter.locale = Locale(identifier: "ko_KR")
            
            return formatter.date(from: self.timestamp)!
        }
    }
}

public enum GraphDateSelectionType: String, CaseIterable {
    case week = "Week"
    case month = "Month"
}

public enum RecentTransactionFilterType: String, CaseIterable {
    case all = "All"
    case income = "Income"
    case expense = "Expense"
}

public enum DataCase {
    case last7Days
    case last30Days
    case latest20Transactions
    case latest10Income
    case latest10Expense
}
