//
//  RecordHomeViewModel.swift
//  muscleMemory
//
//  Created by MadCow on 2024/3/27.
//

import UIKit
import CoreData

class RecordHomeViewModel {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getAllRecord(year: Int, month: Int) -> [RecordModel] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Record")
        let predicate = NSPredicate(format: "date CONTAINS %@", "\(year)-\(month)")
        fetchRequest.predicate = predicate
        
        var records: [RecordModel] = []
        do {
            let allRecords = try context.fetch(fetchRequest) as! [NSManagedObject]
            if allRecords.count > 0 {
                for record in allRecords {
                    let date = record.value(forKey: "date") as! String
                    let title = record.value(forKey: "title") as! String
                    let content = record.value(forKey: "content") as! String
                    let feelingImage = record.value(forKey: "feelingImage") as! String
                    records.append(RecordModel(date: date, title: title, content: content, feelingImage: feelingImage))
                }
            }
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        print(records)
        return records
    }
    
    func getRecordsDay(records: [RecordModel]) -> [Int] {
        return records.map{ record in
            let dateSplit = record.date.split(separator: "-")
            
            return Int(dateSplit[2])!
        }
    }
    
    private let currentDate = Date()
    private let calendar = Calendar.current
    func getCurrentYear() -> Int {
        return calendar.component(.year, from: currentDate)
    }
    
    func getCurrentMonth() -> Int {
        return calendar.component(.month, from: currentDate)
    }
    
    func getCurrentDay() -> Int {
        return calendar.component(.day, from: currentDate)
    }
    
    func getDaysBy(year: Int, month: Int) -> Int {
        if [1, 3, 5, 7, 8, 10, 12].contains(month) {
            return 31
        } else if [4, 6, 9, 11].contains(month) {
            return 30
        } else {
            // 윤달에 따라 28, 29일 체크 추가
            return isLeapYear(year: year) ? 29 : 28
        }
    }
    
    private func isLeapYear(year: Int) -> Bool {
        if year % 4 == 0 {
            if year % 100 == 0 {
                if year % 400 == 0 {
                    return true
                } else {
                    return false
                }
            } else {
                return true
            }
        } else {
            return false
        }
    }
}
