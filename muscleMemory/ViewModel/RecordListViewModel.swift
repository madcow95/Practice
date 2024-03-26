//
//  RecordListViewModel.swift
//  muscleMemory
//
//  Created by MadCow on 2024/3/8.
//

import UIKit
import CoreData

class RecordListViewModel {
    
    let homeViewModel = HomeViewModel()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getWorkoutNameBy(key: String) -> String? {
        let fetchRequest: NSFetchRequest<Workout> = Workout.fetchRequest()
        let predicate = NSPredicate(format: "key == %@", key)
        fetchRequest.predicate = predicate
        
        var returnName: String? = nil
        do {
            let workoutName = try context.fetch(fetchRequest)
            returnName = workoutName[0].name
        } catch let error as NSError {
            print("데이터 가져오기 실패: \(error), \(error.userInfo)")
        }
        
        return returnName
    }
    
    func getWorkoutDetailNameBy(key: String, subKey: String) -> String? {
        let fetchRequest: NSFetchRequest<WorkoutDetail> = WorkoutDetail.fetchRequest()
        let predicate1 = NSPredicate(format: "key == %@", key)
        let predicate2 = NSPredicate(format: "subKey == %@", subKey)
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate1, predicate2])
        fetchRequest.predicate = compoundPredicate
        
        var returnName: String? = nil
        do {
            let workoutName = try context.fetch(fetchRequest)
            returnName = workoutName[0].name
        } catch let error as NSError {
            print("데이터 가져오기 실패: \(error), \(error.userInfo)")
        }
        
        return returnName
    }
}
