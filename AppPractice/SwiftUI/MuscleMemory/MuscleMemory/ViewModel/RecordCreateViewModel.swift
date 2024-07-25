//
//  RecordCreateViewModel.swift
//  MuscleMemory
//
//  Created by MadCow on 2024/4/25.
//

import Foundation
import SwiftUI
import SwiftData
import Combine

class RecordCreateViewModel: ObservableObject {
    @Published var checkWorkout: [String: [(String, Bool)]] = [:]
    @Published var mainWorkouts: [WorkoutModelForDisplay] = []
    @Published var subWorkouts: [WorkoutSubCategory] = []
    @Environment(\.modelContext) var modelContext
    
    init() {
        do {
            let mainDescriptor = FetchDescriptor<WorkoutModelForDisplay>()
            let subDescriptor = FetchDescriptor<WorkoutSubCategory>()
            self.mainWorkouts = try modelContext.fetch(mainDescriptor)
            self.subWorkouts = try modelContext.fetch(subDescriptor)
        } catch {
            print("error in RecordCreateViewModel init() -> \(error.localizedDescription)")
        }
    }
    
    func getAllCheckoutData() -> [String: [(String, Bool)]] {
        for mainWorkout in mainWorkouts {
            let key = mainWorkout.mainCategory
            let subWorkoutNames = subWorkouts.filter{ $0.mainCategory == key }
            for subWorkoutName in subWorkoutNames {
                if checkWorkout[subWorkoutName.mainCategory] == nil {
                    checkWorkout[subWorkoutName.mainCategory] = [(subWorkoutName.subCategory, false)]
                } else {
                    checkWorkout[subWorkoutName.mainCategory]?.append((subWorkoutName.subCategory, false))
                }
            }
        }
        
        return checkWorkout
    }
    
    func removeCheckoutData() {
        
    }
}
