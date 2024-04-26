//
//  ContentView.swift
//  MuscleMemory
//
//  Created by MadCow on 2024/4/24.
//

import SwiftUI
//import SwiftData

struct Workout: Hashable {
    let name: String
    let category: String
}
// 센세 뭔가 스유를 공부하면서 느낀게 화면을 만들기에는 진짜 편한거 같은데 이게 코드가 길어지니까 너무 보기가 불편해서 View를 여러개로 쪼개서 관리하는게 좋을까요?

struct ContentView: View {
    
//    @Query var records: [MainWorkoutModel]
//    @Environment(\.modelContext) var modelContext
    
    @State private var recordCreateIsShowing: Bool = false
    @State private var days: [Date] = []
    @State private var date = Date.now
    @State private var selectedDate: Date = Date.now
    @State private var selectedWorkouts: [Workout] = []
    
    private let daysOfWeek: [String] = ["일", "월", "화", "수", "목", "금", "토"]
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Divider()
                    // 날짜 선택 View
                    HStack {
                        Button {
                            if let nextMonth = Calendar.current.date(byAdding: .month, value: -1, to: date) {
                                date = nextMonth
                            }
                        } label: {
                            Image(systemName: "arrowtriangle.left.fill")
                        }
                        .foregroundStyle(.black)
                        
                        Spacer()
                        
                        Text(date.currentMonthDateString(date: date))
                            .bold()
                        
                        Spacer()
                        
                        Button {
                            if let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: date) {
                                date = nextMonth
                            }
                        } label: {
                            Image(systemName: "arrowtriangle.right.fill")
                        }
                        .foregroundStyle(.black)
                        
                    }
                    .padding()
                    
                    // 요일 표시 View
                    HStack {
                        ForEach(daysOfWeek, id: \.self) { day in
                            Text(day)
                                .fontWeight(.black)
                                .foregroundStyle(Color(UIColor.lightGray))
                                .frame(maxWidth: .infinity)
                        }
                    }
                    
                    // 달력 표시 View
                    LazyVGrid(columns: columns, content: {
                        // MARK: - TODO: 일요일에 빨간색, 토요일에 파란색으로 색칠
                        ForEach(days, id: \.self) { day in
                            if day.monthInt != date.monthInt {
                                Text("")
//                                아래 코드는 이전 월의 날들을 회색으로 표시해주는 Text들
//                                Text(day.formatted(.dateTime.day()))
//                                    .foregroundStyle(Color(UIColor.lightGray))
//                                    .bold()
                            } else {
                                Button {
                                    // MARK: TODO - SwiftData와 연동 후 선택했을 때 해당 날짜에 운동값 있으면 불러오기 ❌
                                    // 날짜 선택하면 선택한 날짜 파란색으로 동그라미 치기 ✅
                                    selectedDate = day
                                } label: {
                                    Text(day.formatted(.dateTime.day()))
                                        .bold()
                                        .frame(maxWidth: .infinity, minHeight: 40)
                                        .background(
                                            Circle()
                                                .foregroundStyle(
                                                    Date.now.startOfDay == day.startOfDay ? .red.opacity(0.3) : 
                                                           selectedDate == day && day.startOfDay <= Date.now.startOfDay ? .blue.opacity(0.3) : .white
                                                )
                                        )
                                }
                                .foregroundStyle(.black)
                            }
                        }
                    })
                    Divider()
                    
                    // 추가하기 공유하기 버튼 HStack View
                    VStack {
                        HStack {
                            Spacer()
                            Button {
                                recordCreateIsShowing = true
                            } label: {
                                HStack {
                                    Image(systemName: "plus")
                                    Text("추가하기")
                                }
                            }
                            Spacer()
                            Button {
                                // 이 버튼은 뺄듯..?
                            } label: {
                                HStack {
                                    Image(systemName: "square.and.arrow.up")
                                    Text("공유하기")
                                }
                            }
                            Spacer()
                        }
                        .padding()
                        .foregroundStyle(Color(UIColor.lightGray))
                        .font(.subheadline)
                        
                        ForEach(selectedWorkouts, id: \.self) { workout in
                            HStack {
                                Text("\(workout.category) (\(workout.name))")
                            }
                        }
                    }
                }
                .navigationTitle("Muscle Memory")
                .padding()
                .navigationDestination(isPresented: $recordCreateIsShowing, destination: {
                    RecordCreateView(recordCreateIsShowing: $recordCreateIsShowing, selectedWorkouts: $selectedWorkouts)
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
                .onAppear {
                    days = date.calendarDisplayDays
                }
                .onChange(of: Date()) {
                    days = date.calendarDisplayDays
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
