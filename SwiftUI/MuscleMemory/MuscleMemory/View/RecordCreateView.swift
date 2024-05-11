//
//  RecordCreateView.swift
//  MuscleMemory
//
//  Created by MadCow on 2024/4/24.
//

import SwiftUI
import SwiftData

// 현재 스크린의 크기 UIWindow().frame.width
struct RecordCreateView: View {
    
    @Query var mainWorkouts: [WorkoutModelForDisplay]
    @Query var subWorkouts: [WorkoutSubCategory]
    @Environment(\.modelContext) var modelContext
    
    // MARK: TODO - workout 데이터들 SwiftData에 저장 ✅
    @State private var checkWorkout: [String: [(String, Bool)]] = [:]
    
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
                                        Button {
                                            let selectedSubWortout = subWorkouts.filter{ $0.mainCategory == main.key && $0.subCategory == chest.0 }
                                            if selectedSubWortout.count > 0 {
                                                modelContext.delete(selectedSubWortout[0])
                                            }
                                        } label: {
                                            Image(systemName: "minus.circle")
                                        }
                                    }
                                    .padding([.top, .leading])
                                    .onTapGesture {
                                        checkWorkout[main.key]?[index].1.toggle()
                                        guard let workout = checkWorkout[main.key] else { return }
                                        if workout[index].1 == true {
                                            tempSelectedWorkouts.insert(Workout(name: main.key, category: chest.0))
                                        }
                                    }
                                }
                            }
                            .padding(.bottom, 30)
                        }
                    }
                }
                .sheet(isPresented: $categoryCreateIsShowing, content: {
                    RecordCategoryCreateView(category: $selectedCategory, checkWorkout: $checkWorkout, categoryCreateIsShowing: $categoryCreateIsShowing)
                        .modelContainer(for: [WorkoutModelForDisplay.self, WorkoutSubCategory.self])
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
        .onAppear {
            // MARK: TODO - ViewModel로 옮기기
            for mainWorkout in mainWorkouts {
                let key = mainWorkout.mainCategory
                let subWorkoutNames = subWorkouts.filter{ $0.mainCategory == key }
                for subWorkoutName in subWorkoutNames {
                    if checkWorkout[subWorkoutName.mainCategory] == nil {
                        checkWorkout[subWorkoutName.mainCategory] = [(subWorkoutName.subCategory, false)]
                    } else {
                        checkWorkout[subWorkoutName.mainCategory]?.append((subWorkoutName.subCategory, false))
                    }
                }
            }
        }
    }
}

//#Preview {
//    RecordCreateView()
//}
