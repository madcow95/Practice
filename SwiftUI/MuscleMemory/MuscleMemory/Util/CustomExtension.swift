//
//  CustomExtension.swift
//  MuscleMemory
//
//  Created by MadCow on 2024/4/24.
//

import UIKit
import SwiftUI

extension Date {
    func currentDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        
        return formatter.string(from: Self())
    }
}
