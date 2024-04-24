//
//  RecordCreateView.swift
//  MuscleMemory
//
//  Created by MadCow on 2024/4/24.
//

import SwiftUI

struct RecordCreateView: View {
    
    @State private var selectedWorkout: String = ""
    private var mainCategorySelected: Bool {
        return !self.selectedWorkout.isEmpty
    }
    @State private var subCategorySelected: Bool = false
    
    var body: some View {
        VStack {
            Picker("선택", selection: $selectedWorkout) {
                Text("가슴").tag("가슴")
                Text("등").tag("등")
                Text("어깨").tag("어깨")
                Text("하체").tag("하체")
            }
            .pickerStyle(.segmented)
            
            if mainCategorySelected {
                SubCategoryView()
            }
        }
        .padding()
    }
}

#Preview {
    RecordCreateView()
}
