//
//  Workout.swift
//  Selfit_Clone
//
//  Created by MadCow on 2024/5/22.
//

import Foundation

struct Records: Codable {
    let reps: [Int]
    let sets: Int
    let weights: [Int]
}

struct Workout: Codable {
    let category: String
    let date: String
    let records: Records
    let subCategory: String
}

struct TopLevelData: Codable {
    let workout: Workout
}
