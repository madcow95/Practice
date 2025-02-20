//
//  MainTabView.swift
//  DELIGHT_LABS_Subject
//
//  Created by MadCow on 2025/2/12.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            Tab("", systemImage: "square.grid.2x2") {
                DashboardView()
            }
            
            Tab("", systemImage: "creditcard") {
                CreditView()
            }
            
            Tab("", systemImage: "waveform") {
                TransactionView()
            }
            
            Tab("", systemImage: "person") {
                ProfileView()
            }
        }
        .tint(.primaryColor)
    }
}

#Preview {
    MainTabView()
}
