//
//  RecordModel.swift
//  MuscleMemory
//
//  Created by MadCow on 2024/4/24.
//

import Foundation
import SwiftData

@Model
class RecordModel {
    let id: UUID = UUID()
    let date: Date
    let mainCategory: [String]
    let subCategory: [String]
    let totalSet: [Int]
    let totalReps: [Int]
    let totalWeights: [Double]
    
    init(date: Date, mainCategory: [String], subCategory: [String], totalSet: [Int], totalReps: [Int], totalWeights: [Double]) {
        self.date = date
        self.mainCategory = mainCategory
        self.subCategory = subCategory
        self.totalSet = totalSet
        self.totalReps = totalReps
        self.totalWeights = totalWeights
    }
}
