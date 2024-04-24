//
//  RecordCreateView.swift
//  MuscleMemory
//
//  Created by MadCow on 2024/4/24.
//

import SwiftUI

// 현재 스크린의 크기 UIWindow().frame.width
struct RecordCreateView: View {
    
    // MARK: TODO - workout 데이터들 SwiftData에 저장
    @State private var checkWorkout: [String: [(String, Bool)]] = [
        "가슴": [
            ("덤벨 플라이", false),
            ("벤치 프레스", false),
            ("체스트 프레스", false)
        ],
        "등": [
            ("랫 풀 다운", false),
            ("시티드 로우", false),
            ("바벨 로우", false)
        ]
    ]
    
    private var selectedWorkoutExist: Bool {
        return checkWorkout.flatMap{ $0.value }.filter{ $0.1 == true }.count > 0
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    VStack(spacing: 0) {
                        ForEach(checkWorkout.sorted{ $0.key < $1.key }, id: \.self.key) { main in
                            VStack(spacing: 0) {
                                HStack {
                                    Text(main.key)
                                        .font(.headline)
                                    
                                    Spacer()
                                    
                                    Button {
                                        print(selectedWorkoutExist)
                                    } label: {
                                        Image(systemName: "plus.circle")
                                            .foregroundStyle(.black)
                                    }
                                }
                                .padding(.bottom, 10)
                                Divider()
                                
                                ForEach(main.value.indices, id: \.self) { index in
                                    let chest = main.value[index]
                                    HStack {
                                        Image(systemName: chest.1 ? "checkmark.circle.fill" : "checkmark.circle")
                                        Text(chest.0)
                                        Spacer()
                                    }
                                    .padding([.top, .leading])
                                    .onTapGesture {
                                        checkWorkout[main.key]?[index].1.toggle()
                                    }
                                }
                            }
                            .padding(.bottom, 30)
                        }
                    }
                }
            }
            .navigationTitle("운동 선택")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    if selectedWorkoutExist {
                        Button("추가") {
                            
                        }
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    RecordCreateView()
}
