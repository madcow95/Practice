//
//  RecordCreateViewModel.swift
//  muscleMemory
//
//  Created by MadCow on 2024/3/28.
//

import UIKit
import CoreData

class RecordCreateViewModel {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private let feelings: [(String, String)] = [
        ("매우 좋음", "sun.max.fill"), ("좋음", "cloud.sun.fill"), ("그냥 그럼", "cloud.fill"), ("슬픔", "cloud.rain.fill"),
        ("매우 슬픔", "cloud.bolt.fill"), ("ㅈ같음", "cloud.bolt.rain.fill")
    ]
    
    func saveRecord(record: RecordModel) {
        print(record)
    }
    
    func getFeelings() -> [(String, String)] {
        return feelings
    }
}
