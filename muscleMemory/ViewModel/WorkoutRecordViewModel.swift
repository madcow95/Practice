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
    
    func getAllWorkoutData() -> [WorkOut] {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Workout")

        do {
            let workOut = try context.fetch(fetchRequest) as! [NSManagedObject]
            if workOut.count > 0 {
//                for work in workOut {
//                    context.delete(work)
//                    let key = work.value(forKey: "key") as! Int
//                    let name = work.value(forKey: "name") as! String
//                    print("key: \(key), Name: \(name)")
//                }
//                try context.save()
                return workOut.map{ WorkOut(key: $0.value(forKey: "key") as! Int, name: $0.value(forKey: "name") as! String) }
            } else {
                recordVM.workOuts.forEach{ work in
                    if let entity = NSEntityDescription.entity(forEntityName: "Workout", in: context) {
                        let newWorkout = NSManagedObject(entity: entity, insertInto: context)
                        newWorkout.setValue(work.key, forKey: "key")
                        newWorkout.setValue(work.name, forKey: "name")
                    }
                }
                
                do {
                    try context.save()
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
        } catch let error as NSError {
            print("데이터 가져오기 실패: \(error), \(error.userInfo)")
        }
        
        return []
    }
    
    func saveWorkoutRecord(stack: [SetRecordHorizontalStack]) {
        // 데이터를 저장할 곳
    }
}
