//
//  ContentView.swift
//  BluetoothTest_1
//
//  Created by MadCow on 2025/2/15.
//

import SwiftUI

struct ContentView: View {
    @StateObject var hkManager = HealthKitManager()
    @State var isPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            
            VStack {
                Text("심박수: \(hkManager.heartRate) BPM")
                    .font(.largeTitle)
                    .bold()
            }
            .onAppear {
                hkManager.requestAuthorization()
            }
        }
    }
}

#Preview {
    ContentView()
}
