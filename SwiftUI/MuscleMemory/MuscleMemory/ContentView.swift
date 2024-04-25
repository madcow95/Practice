//
//  ContentView.swift
//  MuscleMemory
//
//  Created by MadCow on 2024/4/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Query var records: [MainWorkoutModel]
    @Environment(\.modelContext) var modelContext
    
    @State private var recordCreateIsShowing: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(records) { record in
                        Text(record.date.currentDateString())
                    }
                }
            }
            .navigationDestination(isPresented: $recordCreateIsShowing, destination: {
                RecordCreateView()
            })
            .navigationTitle("Health Record")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        recordCreateIsShowing = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
