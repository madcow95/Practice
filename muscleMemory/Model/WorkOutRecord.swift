//
//  WorkOutRecord.swift
//  muscleMemory
//
//  Created by MadCow on 2024/2/29.
//

import Foundation

struct WorkOutRecord {
    let key: String
    let subKey: String
    let set: Int
    let reps: Int
    let weight: Int
}

struct WorkoutRecordKey {
    let year: String
    let month: String
    let day: String
    let workoutKey: String
    let workoutSubKey: String
}
