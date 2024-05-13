//
//  CalendarView.swift
//  MuscleMemory
//
//  Created by MadCow on 2024/5/13.
//

import SwiftUI

struct CalendarView: View {
    
    @State private var days: [Date] = []
    @State private var date = Date.now
    @State private var selectedDate: Date = Date.now
    
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
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            print("hello")
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
