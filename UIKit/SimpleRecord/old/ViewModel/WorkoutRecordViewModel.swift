//
//  RecordViewModel.swift
//  simpleRecord
//
//  Created by MadCow on 2024/3/3.
//

import UIKit
import CoreData

class WorkoutRecordViewModel {
    private let homeViewModel = HomeViewModel()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let workout = Workout()
    
    func getSecondWOrkoutRecordBy(workout: WorkOut) -> [WorkOutDetail] {
        return homeViewModel.getWorkOutDetail(mainWorkout: workout)
    }
    
    func getAllWorkoutData() -> [WorkOut] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Workout")
        do {
            let workOut = try context.fetch(fetchRequest) as! [NSManagedObject]
            if workOut.count > 0 {
                return workOut.map{ WorkOut(key: $0.value(forKey: "key") as! Int, name: $0.value(forKey: "name") as! String) }
            } else {
                homeViewModel.tempData.workOuts.forEach{ work in
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
    
    func saveWorkoutRecord(key: String, subKey: String, stackViews: [SetRecordHorizontalStackDeprecated]) {
        let year = "\(homeViewModel.getCurrentYear())"
        var month = "\(homeViewModel.getCurrentMonth())"
        var day = "\(homeViewModel.getCurrentDay())"
        
        if month.count == 1 {
            month = "0\(month)"
        }
        if day.count == 1 {
            day = "0\(day)"
        }
        
        let workoutDate = "\(year)-\(month)-\(day)"
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WorkoutRecord")
        let predicate = NSPredicate(format: "date == %@", workoutDate)
        fetchRequest.predicate = predicate

        var workoutRecordList: [String: [WorkOutRecord]] = [workoutDate: []]

        do {
            let workoutCheck = try context.fetch(fetchRequest) as! [NSManagedObject]
            if workoutCheck.count > 0 {
                workoutRecordList[workoutDate] = workoutCheck.map{ workout in
                    let key = workout.value(forKey: "key") as! String
                    let subKey = workout.value(forKey: "subKey") as! String
                    let set = workout.value(forKey: "set") as! Int
                    let reps = workout.value(forKey: "reps") as! Int
                    let weight = workout.value(forKey: "weight") as! Int
                    return WorkOutRecord(key: key, subKey: subKey, set: set, reps: reps, weight: weight)
                }
            }
        } catch let error as NSError {
            print("데이터 가져오기 실패: \(error), \(error.userInfo)")
        }
        
        stackViews.enumerated().forEach{ (idx, stack) in
            var reps = 0
            var weight = 0
            stack.subviews.forEach{ ele in
                // tag == 1이면 횟수, 2이면 무게 --> CustomUIContent의 SetRecordHorizontalStack에 정의
                if let tf = ele as? UITextField {
                    if tf.tag == 1 {
                        reps = Int(tf.text!)!
                    } else if tf.tag == 2 {
                        weight = Int(tf.text!)!
                    }
                }
            }
            workoutRecordList[workoutDate]?.append(WorkOutRecord(key: key, subKey: subKey, set: idx + 1, reps: reps, weight: weight))
        }
        
        workoutRecordList[workoutDate]?.forEach{ record in
            if let entity = NSEntityDescription.entity(forEntityName: "WorkoutRecord", in: context) {
                let newWorkoutRecord = NSManagedObject(entity: entity, insertInto: context)
                newWorkoutRecord.setValue(workoutDate, forKey: "date")
                newWorkoutRecord.setValue(record.key, forKey: "key")
                newWorkoutRecord.setValue(record.subKey, forKey: "subKey")
                newWorkoutRecord.setValue(record.reps, forKey: "reps")
                newWorkoutRecord.setValue(record.weight, forKey: "weight")
                newWorkoutRecord.setValue(record.set, forKey: "set")
            }
            
            do {
                try context.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
}
