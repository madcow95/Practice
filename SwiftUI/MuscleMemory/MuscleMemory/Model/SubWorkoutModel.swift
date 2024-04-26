//
//  SubWorkoutModel.swift
//  MuscleMemory
//
//  Created by MadCow on 2024/4/25.
//

import Foundation
//import SwiftData

//@Model
class SubWorkoutModel {
    let id: UUID = UUID()
    let mainCategory: String
    let subCategory: [String]
    let totalSet: [Int]
    let totalReps: [Int]
    let totalWeights: [Double]
    
    init(mainCategory: String, subCategory: [String], totalSet: [Int], totalReps: [Int], totalWeights: [Double]) {
        self.mainCategory = mainCategory
        self.subCategory = subCategory
        self.totalSet = totalSet
        self.totalReps = totalReps
        self.totalWeights = totalWeights
    }
}
