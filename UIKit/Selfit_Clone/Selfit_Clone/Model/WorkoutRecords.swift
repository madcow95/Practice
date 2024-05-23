//
//  Workout.swift
//  Selfit_Clone
//
//  Created by MadCow on 2024/5/22.
//

import Foundation

struct Workout: Codable {
    let date: String
    let categories: [String: Category]
}

// MARK: - Category
struct Category: Codable {
    let exercises: [String: Exercise]
}

// MARK: - Exercise
struct Exercise: Codable {
    let reps: [Int]
    let sets: Int
    let weights: [Int]
}
