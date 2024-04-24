//
//  ContentView.swift
//  MuscleMemory
//
//  Created by MadCow on 2024/4/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Query var records: [RecordModel]
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
            .navigationTitle("Health Record")
            .sheet(isPresented: $recordCreateIsShowing, content: {
                RecordCreateView()
                    .modelContainer(for: RecordModel.self)
            })
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
