//
//  RecordHomeViewModel.swift
//  muscleMemory
//
//  Created by MadCow on 2024/3/27.
//

import UIKit
import CoreData

class RecordHomeViewModel {
    
    let testRecord: [RecordModel] = [
        RecordModel(date: "2024-03-01", title: "1", content: "1111", feelingImage: nil),
        RecordModel(date: "2024-03-03", title: "2", content: "2222", feelingImage: nil),
        RecordModel(date: "2024-03-10", title: "3", content: "3333", feelingImage: nil),
        RecordModel(date: "2024-03-13", title: "4", content: "4444", feelingImage: nil),
        RecordModel(date: "2024-03-23", title: "5", content: "5555", feelingImage: nil),
        RecordModel(date: "2024-03-31", title: "6", content: "6666", feelingImage: nil)
    ]
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getAllRecord() -> [String: [RecordModel]] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Record")
        
        var records: [String: [RecordModel]] = [:]
        do {
            let allRecords = try context.fetch(fetchRequest) as! [NSManagedObject]
            if allRecords.count > 0 {
                allRecords.forEach{ record in
                    let date = record.value(forKey: "date") as! String
                    guard var loadRecord = records[date] else {
                        records[date] = []
                        return
                    }
                    let title = record.value(forKey: "title") as! String
                    let content = record.value(forKey: "content") as! String
                    let feelingImage = record.value(forKey: "feelingImage") as? String
                    loadRecord.append(RecordModel(date: date, title: title, content: content, feelingImage: feelingImage))
                }
            }
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        return records
    }
    
    func getTestRecordDay() -> [Int] {
        return testRecord.map{ Int($0.date.split(separator: "-")[2])! }
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
