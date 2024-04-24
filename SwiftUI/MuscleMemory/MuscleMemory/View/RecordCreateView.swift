//
//  RecordCreateView.swift
//  MuscleMemory
//
//  Created by MadCow on 2024/4/24.
//

import SwiftUI

struct RecordCreateView: View {
    
    @State private var checkWorkout: [(String, Bool)] = [
        ("덤벨 플라이", false),
        ("벤치 프레스", false),
        ("체스트 프레스", false)]
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("가슴")
                    Spacer()
                }
                Divider()
                VStack(spacing: 10) {
                    ForEach(checkWorkout.indices, id: \.self) { index in
                        let chest = checkWorkout[index]
                        HStack {
                            Image(systemName: chest.1 ? "checkmark.circle.fill" : "checkmark.circle")
                            Text(chest.0)
                            Spacer()
                        }
                        .onTapGesture {
                            checkWorkout[index].1.toggle()
                        }
                    }
                }
            }
            .navigationTitle("운동 선택")
        }
        .padding()
    }
}

#Preview {
    RecordCreateView()
}
