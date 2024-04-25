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
    @State private var days: [Date] = []
    @State private var date = Date.now
    
    private let daysOfWeek: [String] = ["일", "월", "화", "수", "목", "금", "토"]
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)

    var body: some View {
        NavigationStack {
            VStack {
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
                
                HStack {
                    // MARK: - TODO: 일요일에 빨간색, 토요일에 파란색으로 색칠
                    ForEach(daysOfWeek, id: \.self) { day in
                        Text(day)
                            .fontWeight(.black)
                            .foregroundStyle(Color(UIColor.lightGray))
                            .frame(maxWidth: .infinity)
                    }
                }
                
                LazyVGrid(columns: columns, content: {
                    ForEach(days, id: \.self) { day in
                        if day.monthInt != date.monthInt {
                            Text("")
                        } else {
                            Button {
                                
                            } label: {
                                Text(day.formatted(.dateTime.day()))
                                    .bold()
                                    .frame(maxWidth: .infinity, minHeight: 40)
                                    .background(
                                        Circle()
                                            .foregroundStyle(
                                                Date.now.startOfDay == day.startOfDay ? .blue.opacity(0.3) : .white
                                            )
                                    )
                            }
                            .foregroundStyle(.black)
                        }
                    }
                })
                Spacer()
            }
            .padding()
            .navigationDestination(isPresented: $recordCreateIsShowing, destination: {
                RecordCreateView()
            })
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        recordCreateIsShowing = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                
//                ToolbarItem(placement: .topBarLeading) {
//                    Text(date.currentDateString())
//                        .bold()
//                }
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

#Preview {
    ContentView()
}
