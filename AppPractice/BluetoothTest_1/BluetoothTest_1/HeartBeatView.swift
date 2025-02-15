//
//  HeartBeatView.swift
//  BluetoothTest_1
//
//  Created by MadCow on 2025/2/15.
//

import SwiftUI

struct HeartBeatView: View {
    @ObservedObject var viewModel: BTViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.connectedDeviceName)
            
            Text("\(viewModel.beatRate) bpm")
        }
    }
}

#Preview {
    HeartBeatView(viewModel: BTViewModel())
}
