//
//  RecordCategoryCreateView.swift
//  MuscleMemory
//
//  Created by MadCow on 2024/4/25.
//

import SwiftUI

struct RecordCategoryCreateView: View {
    
    @Binding var category: String
    @State private var workoutName: String = ""
    @State private var weightGroup: String = "kg"
    @State private var selectedButton: Bool = true
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    HStack {
                        Text("그룹")
                        Spacer()
                    }
                    .padding()
                    CustomText {
                        Text(category)
                            .disabled(true)
                    }
                    
                    HStack {
                        Text("운동")
                        Spacer()
                    }
                    .padding()
                    CustomText {
                        TextField("운동 제목을 입력하세요", text: $workoutName)
                    }
                    
                    HStack {
                        Text("단위")
                        Spacer()
                    }
                    .padding()
                    CustomText {
                        TextField("", text: $weightGroup)
                    }
                    
                    HStack {
                        Text("횟수")
                        Spacer()
                    }
                    .padding()
                    
                    HStack {
                        Spacer()
                        Button {
                            selectedButton = true
                        } label: {
                            Text("포함")
                                .padding()
                                .frame(width: UIWindow().frame.width / 2.25, height: 40)
                                .foregroundStyle(.white)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(selectedButton ? Color(UIColor.lightGray) : Color(UIColor.darkGray))
                                )
                        }
                        Spacer()
                        Button {
                            selectedButton = false
                        } label: {
                            Text("제외")
                                .padding()
                                .frame(width: UIWindow().frame.width / 2.25, height: 40)
                                .foregroundStyle(.white)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(selectedButton ? Color(UIColor.darkGray) : Color(UIColor.lightGray))
                                )
                        }
                        Spacer()
                        
                    }
                }
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        
                    } label: {
                        CustomText {
                            Text("저장")
                        }
                    }
                    .disabled(workoutName.isEmpty)
                }
            }
        }
    }
}

//#Preview {
//    RecordCategoryCreateView(category: "")
//}
