//
//  RecordListViewModel.swift
//  muscleMemory
//
//  Created by MadCow on 2024/3/8.
//

import UIKit

class RecordListViewModel {
    
    let homeViewModel = HomeViewModel()
    
    func getRecordName(record: WorkOutRecord) -> [String: String] {
        let recordInfo = record.totalKey.split(separator: "/")
        
        let recordName = homeViewModel.getWorkoutNameBy(key: String(recordInfo[1]))
        let recordDetailName = homeViewModel.getWorkoutDetailNameBy(key: String(recordInfo[1]), subKey: String(recordInfo[2]))
        return ["date": String(recordInfo[0]), "name": recordName[0].name, "nameDetail": recordDetailName[0].name]
    }
}
