//
//  HomeViewModel.swift
//  muscleMemory
//
//  Created by MadCow on 2024/2/29.
//

import UIKit
import CoreData

class HomeViewModel {
    
    let tempData = TempDatas()
    let currentDate = Date()
    let calendar = Calendar.current
    
    let workoutRecords: [String: [WorkOutRecord]] = [
        "2024-03-01": [
            WorkOutRecord(key: "1", subKey: "1", set: 1, reps: 10, weight: 100),
            WorkOutRecord(key: "1", subKey: "1", set: 2, reps: 8, weight: 105),
            WorkOutRecord(key: "1", subKey: "1", set: 3, reps: 6, weight: 110),
            WorkOutRecord(key: "1", subKey: "1", set: 4, reps: 4, weight: 115),
            WorkOutRecord(key: "1", subKey: "1", set: 5, reps: 8, weight: 100),
            WorkOutRecord(key: "1", subKey: "2", set: 1, reps: 10, weight: 80),
            WorkOutRecord(key: "1", subKey: "2", set: 2, reps: 8, weight: 85),
            WorkOutRecord(key: "1", subKey: "2", set: 3, reps: 6, weight: 90),
            WorkOutRecord(key: "1", subKey: "2", set: 4, reps: 4, weight: 95),
            WorkOutRecord(key: "1", subKey: "2", set: 5, reps: 8, weight: 80)
        ],
        "2024-03-06": [
            WorkOutRecord(key: "2", subKey: "1", set: 1, reps: 10, weight: 50),
            WorkOutRecord(key: "2", subKey: "1", set: 2, reps: 8, weight: 55),
            WorkOutRecord(key: "2", subKey: "1", set: 3, reps: 6, weight: 60),
            WorkOutRecord(key: "2", subKey: "1", set: 4, reps: 4, weight: 65),
            WorkOutRecord(key: "2", subKey: "1", set: 5, reps: 8, weight: 40),
            WorkOutRecord(key: "2", subKey: "2", set: 1, reps: 10, weight: 40),
            WorkOutRecord(key: "2", subKey: "2", set: 2, reps: 8, weight: 40),
            WorkOutRecord(key: "2", subKey: "2", set: 3, reps: 6, weight: 40),
            WorkOutRecord(key: "2", subKey: "2", set: 4, reps: 4, weight: 40),
            WorkOutRecord(key: "2", subKey: "2", set: 5, reps: 8, weight: 40)
        ],
        "2024-03-13": [
            WorkOutRecord(key: "3", subKey: "2", set: 1, reps: 10, weight: 50),
            WorkOutRecord(key: "3", subKey: "2", set: 2, reps: 8, weight: 55),
            WorkOutRecord(key: "3", subKey: "2", set: 3, reps: 6, weight: 60),
            WorkOutRecord(key: "3", subKey: "2", set: 4, reps: 4, weight: 65),
            WorkOutRecord(key: "3", subKey: "2", set: 5, reps: 8, weight: 40),
            WorkOutRecord(key: "4", subKey: "3", set: 1, reps: 10, weight: 40),
            WorkOutRecord(key: "4", subKey: "3", set: 2, reps: 8, weight: 40),
            WorkOutRecord(key: "4", subKey: "3", set: 3, reps: 6, weight: 40),
            WorkOutRecord(key: "4", subKey: "3", set: 4, reps: 4, weight: 40),
            WorkOutRecord(key: "4", subKey: "3", set: 5, reps: 8, weight: 40)
        ]
    ]
    /*
    // WorkOutRecord의 totalKey를 dictionary로 만들어서 저장? 할까?
    private let testRecord: [WorkOutRecord] = [
        WorkOutRecord(key: "1", totalKey: "2024-02-01/1/1", date: Date(), set: 3, reps: 12, weight: 100),
        WorkOutRecord(key: "1", totalKey: "2024-02-01/1/1", date: Date(), set: 3, reps: 12, weight: 110),
        WorkOutRecord(key: "1", totalKey: "2024-02-01/1/1", date: Date(), set: 3, reps: 12, weight: 120),
        WorkOutRecord(key: "1", totalKey: "2024-02-01/1/1", date: Date(), set: 3, reps: 12, weight: 130),
        WorkOutRecord(key: "1", totalKey: "2024-02-06/1/2", date: Date(), set: 4, reps: 11, weight: 120),
        WorkOutRecord(key: "1", totalKey: "2024-02-11/1/3", date: Date(), set: 4, reps: 8, weight: 130),
        WorkOutRecord(key: "1", totalKey: "2024-02-25/1/4", date: Date(), set: 5, reps: 9, weight: 140),
        WorkOutRecord(key: "1", totalKey: "2024-02-28/2/3", date: Date(), set: 5, reps: 10, weight: 150),
        WorkOutRecord(key: "1", totalKey: "2024-03-02/1/1", date: Date(), set: 4, reps: 12, weight: 110),
        WorkOutRecord(key: "1", totalKey: "2024-03-02/1/2", date: Date(), set: 3, reps: 12, weight: 120),
        WorkOutRecord(key: "1", totalKey: "2024-03-02/1/3", date: Date(), set: 2, reps: 12, weight: 130),
        WorkOutRecord(key: "1", totalKey: "2024-03-02/1/4", date: Date(), set: 5, reps: 12, weight: 140),
        WorkOutRecord(key: "1", totalKey: "2024-03-07/1/2", date: Date(), set: 4, reps: 11, weight: 120),
        WorkOutRecord(key: "1", totalKey: "2024-03-12/1/3", date: Date(), set: 4, reps: 8, weight: 130),
        WorkOutRecord(key: "1", totalKey: "2024-03-20/1/3", date: Date(), set: 4, reps: 8, weight: 130),
        WorkOutRecord(key: "1", totalKey: "2024-03-20/1/4", date: Date(), set: 4, reps: 8, weight: 130),
        WorkOutRecord(key: "1", totalKey: "2024-03-24/1/3", date: Date(), set: 4, reps: 8, weight: 130),
        WorkOutRecord(key: "1", totalKey: "2024-03-26/1/4", date: Date(), set: 5, reps: 9, weight: 140),
        WorkOutRecord(key: "1", totalKey: "2024-03-29/2/3", date: Date(), set: 5, reps: 10, weight: 150)
    ]
    */
    
    func getWorkOutDetail(mainWorkout: WorkOut) -> [WorkOutDetail] {
        let key = mainWorkout.key
        
        return tempData.workOutDetails.filter{$0.key == key}
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
    
    func getAllRecordsBySelected(year: Int, month: Int) -> [Int] {
        let records = workoutRecords.filter{ record -> Bool in
            let date = record.key.split(separator: "-")
            let years = date[0]
            let months = date[1]
            
            return Int(years)! == year && Int(months)! == month
        }.sorted{ $0.key < $1.key }.map{ $0.key.split(separator: "-")[2] }.map{ Int($0)! }
        
        return records
    }
    
    func getSelectedWorkoutBy(date: String) -> [WorkOutRecord]? {
        return workoutRecords[date]
    }
    
    func getCurrentYear() -> Int {
        return calendar.component(.year, from: currentDate)
    }
    
    func getCurrentMonth() -> Int {
        return calendar.component(.month, from: currentDate)
    }
    
    func getCurrentDay() -> Int {
        return calendar.component(.day, from: currentDate)
    }
    
    func getWorkoutNameBy(key: String) -> [WorkOut] {
        return tempData.workOuts.filter{"\($0.key)" == key}
    }
    
    func getWorkoutDetailNameBy(key: String, subKey: String) -> [WorkOutDetail] {
        return tempData.workOutDetails.filter{"\($0.key)" == key && "\($0.subKey)" == subKey}
    }
}
