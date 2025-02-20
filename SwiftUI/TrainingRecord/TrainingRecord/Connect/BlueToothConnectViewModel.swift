//
//  BlueToothConnectViewModel.swift
//  TrainingRecord
//
//  Created by MadCow on 2025/2/21.
//

import Foundation
import SwiftUI

class BlueToothConnectViewModel: ObservableObject {
    @ObservedObject private var hkManager: HealthKitManager
    @Published var deviceName: String = "기기 연결 중..."
    @Published var heartRate: Double = 0
    
    init(hkManager: HealthKitManager) {
        self.hkManager = hkManager
        hkManager.fetchAppleWatchDeviceInfo() {
            self.deviceName = $0
        }
        
        hkManager.$heartRate
            .assign(to: &$heartRate)
    }
}
