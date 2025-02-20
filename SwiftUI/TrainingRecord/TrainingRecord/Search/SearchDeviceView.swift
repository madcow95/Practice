//
//  SearchDeviceView.swift
//  TrainingRecord
//
//  Created by MadCow on 2025/2/21.
//

import SwiftUI

struct SearchDeviceView: View {
    @ObservedObject var connectViewModel: BlueToothConnectViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            
        }
    }
}

#Preview {
    SearchDeviceView(connectViewModel: BlueToothConnectViewModel(hkManager: HealthKitManager()))
}
