//
//  RecordViewModel.swift
//  muscleMemory
//
//  Created by MadCow on 2024/3/3.
//

import UIKit
import CoreData

class WorkoutRecordViewModel {
    private let recordVM = HomeViewModel()
    var managedObjectContext: NSManagedObjectContext!
    let workout = Workout()
    
    func getFirstWorkoutNames() -> [WorkOut] {
        return recordVM.getAllWorkOut()
    }
    
    func getSecondWOrkoutRecordBy(workout: WorkOut) -> [WorkOutDetail] {
        return recordVM.getWorkOutDetail(mainWorkout: workout)
    }
    
    func getAllWorkoutData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        print(appDelegate)
    }
}
