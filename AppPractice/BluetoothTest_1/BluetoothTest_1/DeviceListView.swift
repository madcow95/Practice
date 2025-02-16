//
//  DeviceListView.swift
//  BluetoothTest_1
//
//  Created by MadCow on 2025/2/15.
//

import SwiftUI

struct DeviceListView: View {
    @ObservedObject var viewModel = BTViewModel()
    @Environment(\.dismiss) var dismiss
    let completion: (String) -> Void
    
    var body: some View {
        List(viewModel.deviceNames, id: \.self) { device in
            Button {
                completion(device)
                viewModel.connectToDevice(name: device)
                dismiss()
            } label: {
                Text(device)
            }
        }
    }
}

#Preview {
    DeviceListView() { _ in }
}
