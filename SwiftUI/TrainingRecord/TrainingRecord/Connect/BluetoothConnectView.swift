//
//  ContentView.swift
//  TrainingRecord
//
//  Created by MadCow on 2025/2/21.
//

import SwiftUI

struct BluetoothConnectView: View {
    @StateObject var viewModel: BlueToothConnectViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("현재 연결된 기기")
                    .font(.largeTitle)
                Text("\(viewModel.deviceName)")
                    .font(.title)
                Text("현재 심장박동 수: \(viewModel.heartRate, specifier: "%.0f") BPM")
            }
            .padding()
        }
    }
}

#Preview {
    BluetoothConnectView(viewModel: BlueToothConnectViewModel(hkManager: HealthKitManager()))
}
