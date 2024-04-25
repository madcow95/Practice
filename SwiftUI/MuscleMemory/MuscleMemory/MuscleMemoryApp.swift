//
//  MuscleMemoryApp.swift
//  MuscleMemory
//
//  Created by MadCow on 2024/4/24.
//

import SwiftUI
import SwiftData

@main
struct MuscleMemoryApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: MainWorkoutModel.self)
        }
    }
}
