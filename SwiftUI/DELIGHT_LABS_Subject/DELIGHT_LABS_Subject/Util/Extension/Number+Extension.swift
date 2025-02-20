//
//  Number+Extension.swift
//  DELIGHT_LABS_Subject
//
//  Created by MadCow on 2025/2/12.
//

import Foundation

extension Double {
    // MARK: 소수점 둘 째 자리까지 표시
    var getTwoDecimal: Double {
        get {
            return Double(String(format: "%.2f", self))!
        }
    }
    
    // MARK: 1000자리 숫자가 넘어갈 때 1,000과 같은 형식으로 표현
    func formattedSeparator() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = ","
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}
