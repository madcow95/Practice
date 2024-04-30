//
//  WorkoutModelForDisplay.swift
//  MuscleMemory
//
//  Created by MadCow on 2024/4/30.
//

import Foundation
import SwiftData

@Model
class WorkoutModelForDisplay {
    let id: UUID = UUID()
    let mainCategory: String
    
    init(mainCategory: String) {
        self.mainCategory = mainCategory
    }
}

@Model
class WorkoutSubCategory {
    let id: UUID = UUID()
    let mainCategory: String
    let subCategory: String
    
    init(mainCategory: String, subCategory: String) {
        self.mainCategory = mainCategory
        self.subCategory = subCategory
    }
}
