//
//  TrainingRecordApp.swift
//  TrainingRecord
//
//  Created by MadCow on 2025/2/21.
//

import SwiftUI

@main
struct TrainingRecordApp: App {
    var body: some Scene {
        WindowGroup {
            BluetoothConnectView(viewModel: BlueToothConnectViewModel(hkManager: HealthKitManager()))
        }
    }
}
