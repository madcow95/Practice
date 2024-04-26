//
//  RecordModel.swift
//  MuscleMemory
//
//  Created by MadCow on 2024/4/24.
//

import Foundation
//import SwiftData

//@Model
class MainWorkoutModel {
    let id: UUID = UUID()
    let date: Date
    let mainCategory: [String]
    
    init(date: Date, mainCategory: [String]) {
        self.date = date
        self.mainCategory = mainCategory
    }
}
