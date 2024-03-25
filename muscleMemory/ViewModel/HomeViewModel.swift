//
//  HomeViewModel.swift
//  muscleMemory
//
//  Created by MadCow on 2024/2/29.
//

import UIKit
import CoreData

class HomeViewModel {
    
    // DB에 저장되어야 할 내용들
    var workOuts: [WorkOut] = [
        WorkOut(key: 1, name: "하체"),
        WorkOut(key: 2, name: "가슴"),
        WorkOut(key: 3, name: "등"),
        WorkOut(key: 4, name: "이두"),
        WorkOut(key: 5, name: "삼두"),
        WorkOut(key: 6, name: "어깨")
    ]
    
    private var workOutDetails: [WorkOutDetail] = [
        WorkOutDetail(key: 1, subKey: 1, name: "스쿼트"),
        WorkOutDetail(key: 1, subKey: 2, name: "레그 프레스"),
        WorkOutDetail(key: 1, subKey: 3, name: "레그 컬"),
        WorkOutDetail(key: 1, subKey: 4, name: "힙 쓰러스트"),
        
        WorkOutDetail(key: 2, subKey: 1, name: "벤치 프레스"),
        WorkOutDetail(key: 2, subKey: 2, name: "체스트 플라이"),
        WorkOutDetail(key: 2, subKey: 3, name: "인클라인 벤치프레스"),
        WorkOutDetail(key: 2, subKey: 4, name: "덤벨 프레스"),
        
        WorkOutDetail(key: 3, subKey: 1, name: "랫 풀 다운"),
        WorkOutDetail(key: 3, subKey: 2, name: "시티드 로우"),
        WorkOutDetail(key: 3, subKey: 3, name: "원 암 덤벨 로우"),
        WorkOutDetail(key: 3, subKey: 4, name: "바벨 로우"),
        
        WorkOutDetail(key: 4, subKey: 1, name: "덤벨 컬"),
        WorkOutDetail(key: 4, subKey: 2, name: "바벨 컬"),
        WorkOutDetail(key: 4, subKey: 3, name: "이두 운동 1"),
        WorkOutDetail(key: 4, subKey: 4, name: "이두 운동 2"),
        
        WorkOutDetail(key: 5, subKey: 1, name: "삼두 운동 1"),
        WorkOutDetail(key: 5, subKey: 2, name: "삼두 운동 2"),
        WorkOutDetail(key: 5, subKey: 3, name: "삼두 운동 3"),
        WorkOutDetail(key: 5, subKey: 4, name: "삼두 운동 4"),
        
        WorkOutDetail(key: 6, subKey: 1, name: "밀리터리 프레스"),
        WorkOutDetail(key: 6, subKey: 2, name: "숄더 프레스"),
        WorkOutDetail(key: 6, subKey: 3, name: "어깨 운동 1"),
        WorkOutDetail(key: 6, subKey: 4, name: "어깨 운동 2")
    ]
    
    let workoutRecords: [String: [WorkOutRecord2]] = [
        "2024-02-01": [
            WorkOutRecord2(key: "1", subKey: "1", set: 1, reps: 10, weight: 100),
            WorkOutRecord2(key: "1", subKey: "1", set: 2, reps: 8, weight: 105),
            WorkOutRecord2(key: "1", subKey: "1", set: 3, reps: 6, weight: 110),
            WorkOutRecord2(key: "1", subKey: "1", set: 4, reps: 4, weight: 115),
            WorkOutRecord2(key: "1", subKey: "1", set: 5, reps: 8, weight: 100),
            WorkOutRecord2(key: "1", subKey: "2", set: 1, reps: 10, weight: 80),
            WorkOutRecord2(key: "1", subKey: "2", set: 2, reps: 8, weight: 85),
            WorkOutRecord2(key: "1", subKey: "2", set: 3, reps: 6, weight: 90),
            WorkOutRecord2(key: "1", subKey: "2", set: 4, reps: 4, weight: 95),
            WorkOutRecord2(key: "1", subKey: "2", set: 5, reps: 8, weight: 80)
        ],
        "2024-02-06": [
            WorkOutRecord2(key: "2", subKey: "1", set: 1, reps: 10, weight: 50),
            WorkOutRecord2(key: "2", subKey: "1", set: 2, reps: 8, weight: 55),
            WorkOutRecord2(key: "2", subKey: "1", set: 3, reps: 6, weight: 60),
            WorkOutRecord2(key: "2", subKey: "1", set: 4, reps: 4, weight: 65),
            WorkOutRecord2(key: "2", subKey: "1", set: 5, reps: 8, weight: 40),
            WorkOutRecord2(key: "2", subKey: "2", set: 1, reps: 10, weight: 40),
            WorkOutRecord2(key: "2", subKey: "2", set: 2, reps: 8, weight: 40),
            WorkOutRecord2(key: "2", subKey: "2", set: 3, reps: 6, weight: 40),
            WorkOutRecord2(key: "2", subKey: "2", set: 4, reps: 4, weight: 40),
            WorkOutRecord2(key: "2", subKey: "2", set: 5, reps: 8, weight: 40)
        ],
        "2024-02-13": [
            WorkOutRecord2(key: "3", subKey: "2", set: 1, reps: 10, weight: 50),
            WorkOutRecord2(key: "3", subKey: "2", set: 2, reps: 8, weight: 55),
            WorkOutRecord2(key: "3", subKey: "2", set: 3, reps: 6, weight: 60),
            WorkOutRecord2(key: "3", subKey: "2", set: 4, reps: 4, weight: 65),
            WorkOutRecord2(key: "3", subKey: "2", set: 5, reps: 8, weight: 40),
            WorkOutRecord2(key: "3", subKey: "3", set: 1, reps: 10, weight: 40),
            WorkOutRecord2(key: "3", subKey: "3", set: 2, reps: 8, weight: 40),
            WorkOutRecord2(key: "3", subKey: "3", set: 3, reps: 6, weight: 40),
            WorkOutRecord2(key: "3", subKey: "3", set: 4, reps: 4, weight: 40),
            WorkOutRecord2(key: "3", subKey: "3", set: 5, reps: 8, weight: 40)
        ]
    ]
    
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
    
    func getWorkOutDetail(mainWorkout: WorkOut) -> [WorkOutDetail] {
        let key = mainWorkout.key
        
        return workOutDetails.filter{$0.key == key}
    }
    
    func getDaysBy(month: Int) -> Int {
        if [1, 3, 5, 7, 8, 10, 12].contains(month) {
            return 31
        } else if [4, 6, 9, 11].contains(month) {
            return 30
        } else {
            // MARK: TODO - 윤달은 어떻게 처리할 것인지
            return 28
        }
    }
    
    func getAllTestRecordBy(year: Int, month: Int) -> [WorkOutRecord] {
        
        let test = workoutRecords.filter{ record -> Bool in
            let date = record.key.split(separator: "-")
            let years = date[0]
            let months = date[1]
            
            return Int(years)! == year && Int(months)! == month
        }
        
        print(test)
        
        return testRecord.filter{record -> Bool in
            let dates = record.totalKey.split(separator: "/")[0]
            let dateData = dates.split(separator: "-")
            let years = dateData[0]
            let months = dateData[1]
            
            return Int(years)! == year && Int(months)! == month
        }
    }
    
    func getTestRecordBy(date: String) -> [WorkOutRecord] {
        return testRecord.filter{$0.totalKey.split(separator: "/")[0].contains(date)}
    }
    
    func getCurrentDate() -> [String: String] {
        let currentDate = Date()
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: currentDate)
        let currentMonth = calendar.component(.month, from: currentDate)
        let currentDay = calendar.component(.day, from: currentDate)
        
        return ["year": "\(currentYear)", "month": "\(currentMonth)", "day": "\(currentDay)"]
    }
    
    func getWorkoutNameBy(key: String) -> [WorkOut] {
        return workOuts.filter{"\($0.key)" == key}
    }
    
    func getWorkoutDetailNameBy(key: String, subKey: String) -> [WorkOutDetail] {
        return workOutDetails.filter{"\($0.key)" == key && "\($0.subKey)" == subKey}
    }
}
