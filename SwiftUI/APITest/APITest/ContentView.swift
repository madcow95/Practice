//
//  ContentView.swift
//  APITest
//
//  Created by MadCow on 2024/4/16.
//

import SwiftUI

struct ContentView: View {
    let viewModel = APITestViewModel()
    var body: some View {
        VStack {
            Button {
                viewModel.test()
            } label: {
                Text("TEST")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
