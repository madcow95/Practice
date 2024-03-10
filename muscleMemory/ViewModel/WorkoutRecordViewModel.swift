//
//  RecordViewModel.swift
//  muscleMemory
//
//  Created by MadCow on 2024/3/3.
//

import UIKit

class WorkoutRecordViewModel {
    private let recordVM = HomeViewModel()
    
    func getFirstWorkoutNames() -> [WorkOut] {
        return recordVM.getAllWorkOut()
    }
    
    func getSecondWOrkoutRecordBy(workout: WorkOut) -> [WorkOutDetail] {
        return recordVM.getWorkOutDetail(mainWorkout: workout)
    }
}
