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
        ],
        "어깨": [
            ("숄더 프레스", false),
            ("밀리터리 프레스", false),
            ("사이드 레터럴 레이즈", false)
        ],
        "하체": [
            ("스쿼트", false),
            ("레그 프레스", false),
            ("레그 익스텐션", false)
        ]
    ]
    @State private var categoryCreateIsShowing: Bool = false
    @State private var selectedCategory: String = ""
    
    @Binding var recordCreateIsShowing: Bool
    @Binding var selectedWorkouts: [Workout]
    
    @State var tempSelectedWorkouts: Set<Workout> = []
    
    private var selectedWorkoutExist: Bool {
        return checkWorkout.flatMap{ $0.value }.filter{ $0.1 == true }.count > 0
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    VStack(spacing: 0) {
                        // Dictionary를 ForEach에서 사용할 때 sorted를 해줘야 한다?
                        ForEach(checkWorkout.sorted{ $0.key < $1.key }, id: \.self.key) { main in
                            VStack(spacing: 0) {
                                HStack {
                                    Text(main.key)
                                        .font(.headline)
                                    
                                    Spacer()
                                    
                                    Button {
                                        selectedCategory = main.key
                                        categoryCreateIsShowing = true
                                    } label: {
                                        Image(systemName: "plus.circle")
                                            .foregroundStyle(.primary)
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
                                        guard let workout = checkWorkout[main.key] else { return }
                                        if workout[index].1 == true {
                                            tempSelectedWorkouts.insert(Workout(name: main.key, category: chest.0))
                                        }
//                                        if checkWorkout[main.key]?[index].1 == true {
//                                            if !tempSelectedWorkouts.contains(main.key) {
//                                                tempSelectedWorkouts.append(main.key)
//                                            }
//                                        } else {
//                                            if tempSelectedWorkouts.contains(main.key) {
//                                                guard let index = tempSelectedWorkouts.firstIndex(of: main.key) else { return }
//                                                tempSelectedWorkouts.remove(at: index)
//                                            }
//                                        }
                                    }
                                }
                            }
                            .padding(.bottom, 30)
                        }
                    }
                }
                .sheet(isPresented: $categoryCreateIsShowing, content: {
                    RecordCategoryCreateView(category: $selectedCategory, checkWorkout: $checkWorkout, categoryCreateIsShowing: $categoryCreateIsShowing)
                })
            }
            .navigationTitle("운동 선택")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    if selectedWorkoutExist {
                        Button("추가") {
                            recordCreateIsShowing = false
                            selectedWorkouts = Array(tempSelectedWorkouts)
                        }
                    }
                }
            }
        }
        .padding()
    }
}

//#Preview {
//    RecordCreateView()
//}
