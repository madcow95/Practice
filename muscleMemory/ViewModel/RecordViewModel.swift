//
//  RecordViewModel.swift
//  muscleMemory
//
//  Created by MadCow on 2024/3/3.
//

import UIKit

class RecordViewModel {
    private let recordVM = HomeViewModel()
    
    func getFirstWorkoutNames() -> [String] {
        return recordVM.getAllWorkOut().map { $0.name }
    }
}
