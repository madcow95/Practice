//
//  ContentView.swift
//  BluetoothTest_1
//
//  Created by MadCow on 2025/2/15.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = BTViewModel()
    @State var isPresented: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            Button {
                isPresented = true
            } label: {
                Text("기기 찾기")
            }
            
            Text("연결된 기기: \(viewModel.connectedDeviceName)")
            
            NavigationLink {
                HeartBeatView(viewModel: viewModel)
            } label: {
                Text("\(viewModel.connectedDeviceName) 연결 화면 이동")
            }

        }
        .sheet(isPresented: $isPresented) {
            DeviceListView(viewModel: viewModel) { name in
                viewModel.connectedDeviceName = name
            }
        }
    }
}

#Preview {
    ContentView()
}
