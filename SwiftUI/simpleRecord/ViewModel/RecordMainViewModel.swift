//
//  RecordMainViewModel.swift
//  simpleRecord
//
//  Created by MadCow on 2024/4/4.
//

import Foundation

class RecordMainViewModel {
    
    let dummyData: [String: RecordModel] = [
        "2024-4-1": RecordModel(title: "제목1", date: "2024-4-1", feelingImage: "sun.max.fill", content: "내용1"),
        "2024-4-3": RecordModel(title: "제목2", date: "2024-4-3", feelingImage: "cloud.sun.fill", content: "내용2"),
        "2024-4-5": RecordModel(title: "제목3", date: "2024-4-5", feelingImage: "cloud.fill", content: "내용3"),
        "2024-4-6": RecordModel(title: "제목4", date: "2024-4-6", feelingImage: "sun.max.fill", content: "내용4"),
        "2024-4-8": RecordModel(title: "제목5", date: "2024-4-8", feelingImage: "cloud.rain.fill", content: "내용5"),
        "2024-4-12": RecordModel(title: "제목6", date: "2024-4-12", feelingImage: "cloud.fill", content: "내용6"),
        "2024-4-15": RecordModel(title: "제목7", date: "2024-4-15", feelingImage: "cloud.bolt.rain.fill", content: "내용7"),
        "2024-4-18": RecordModel(title: "제목8", date: "2024-4-18", feelingImage: "cloud.fill", content: "내용8"),
        "2024-4-20": RecordModel(title: "제목9", date: "2024-4-20", feelingImage: "sun.max.fill", content: "내용9"),
        "2024-4-25": RecordModel(title: "제목10", date: "2024-4-25", feelingImage: "cloud.rain.fill", content: "내용10"),
        
        "2024-5-12": RecordModel(title: "제목11", date: "2024-5-12", feelingImage: "cloud.fill", content: "내용11"),
        "2024-5-20": RecordModel(title: "제목12", date: "2024-5-20", feelingImage: "sun.max.fill", content: "내용12"),
        "2024-3-30": RecordModel(title: "제목13", date: "2024-3-30", feelingImage: "cloud.rain.fill", content: "내용13"),
    ]
    
    func getDummyDatas() -> [String: RecordModel] {
        return dummyData
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
    
    func increaseMonth(year: Int, month: Int) -> (Int, Int) {
        var copiedYear: Int = year
        var copiedMonth: Int = month
        
        copiedMonth += 1
        
        if copiedMonth > 12 {
            copiedMonth = 1
            copiedYear += 1
        }
        
        return (copiedYear, copiedMonth)
    }
    
    func decreaseMonth(year: Int, month: Int) -> (Int, Int) {
        var copiedYear: Int = year
        var copiedMonth: Int = month
        
        copiedMonth -= 1
        
        if copiedMonth < 1 {
            copiedMonth = 12
            copiedYear -= 1
        }
        
        return (copiedYear, copiedMonth)
    }
}
