//
//  RecordCreateView.swift
//  MuscleMemory
//
//  Created by MadCow on 2024/4/24.
//

import SwiftUI

// 현재 스크린의 크기 UIWindow().frame.width
struct RecordCreateView: View {
    
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
        }
        .padding()
    }
}

#Preview {
    RecordCreateView()
}
