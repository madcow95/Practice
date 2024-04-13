//
//  RecordMainView.swift
//  simpleRecord
//
//  Created by MadCow on 2024/4/4.

import SwiftUI

struct RecordMainView: View {
    
    private let recordMainViewModel = RecordMainViewModel()
    
    let data = (1...31).map{ "\($0)" }
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 7)
    let width: CGFloat = UIScreen.main.bounds.width / 7
    
    @State var currentYear: Int
    @State var currentMonth: Int
    @State var dummyData: [String: RecordModel]
    @State private var selectedRecord: RecordModel?
    @State private var createViewPresented = false
    @State private var editViewPresented = false
    
    init() {
        _currentYear = State(initialValue: recordMainViewModel.getCurrentYear())
        _currentMonth = State(initialValue: recordMainViewModel.getCurrentMonth())
        _dummyData = State(initialValue: recordMainViewModel.getDummyDatas())
    }
    
    var body: some View {
        
        VStack {
            HStack {
                
                HStack {
                    Button(action: {
                        let decreaseResult: (Int, Int) = recordMainViewModel.decreaseMonth(year: currentYear, month: currentMonth)
                        currentYear = decreaseResult.0
                        currentMonth = decreaseResult.1
                    }, label: {
                        Image(systemName: "arrowtriangle.left.fill")
                            .foregroundStyle(Color.black)
                    })
                    
                    Text("\(String(currentYear))년 \(currentMonth)월")
                    
                    Button(action: {
                        let increaseResult: (Int, Int) = recordMainViewModel.increaseMonth(year: currentYear, month: currentMonth)
                        currentYear = increaseResult.0
                        currentMonth = increaseResult.1
                    }, label: {
                        Image(systemName: "arrowtriangle.right.fill")
                            .foregroundStyle(Color.black)
                    })
                }
                .padding(.horizontal)
                
                Spacer()
                
                Button {
                    let date: String = "\(currentYear)-\(currentMonth)-\(recordMainViewModel.getCurrentDay())"
                    createViewPresented = dummyData[date] == nil
//                    guard let _ = dummyData[date] else {
//                        // MARK: - TODO. 이미 작성된 일기가 있어 수정할래? 알림창 띄움(재사용 가능하게)
//                        return
//                    }
//                    createViewPresented.toggle()
                } label: {
                    Text("일기쓰기")
                        .padding()
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }
                .frame(height: 40)
                .background(Capsule().fill(Color.blue))
                .padding(.horizontal)
                .sheet(isPresented: $createViewPresented, content: {
                    RecordCreateView()
                })
            }
            .padding(.top)
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(data, id: \.self) { item in
                        VStack {
                            Spacer()
                            
                            Text(item)
                            
                            Spacer()
                            
                            if let dummy = dummyData["\(currentYear)-\(currentMonth)-\(item)"] {
                                Image(systemName: dummy.feelingImage)
                                    .frame(width: 30, height: 30)
                            } else {
                                Image(systemName: "")
                                    .frame(width: 30, height: 30)
                            }
                            Spacer()
                        }
                        .frame(width: width / 1.2, height: CGFloat(width * 1.5))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
                        )
                        .onTapGesture {
                            
                            let currentDate: String = "\(currentYear)-\(currentMonth)-\(item)"
                            guard let record = dummyData[currentDate] else {
                                // MARK: - TODO. 이미 작성된 일기가 있어 수정할래? 알림창 띄움(재사용 가능하게)
                                return
                            }
                            self.selectedRecord = record
                            editViewPresented.toggle()
                        }
                        .sheet(isPresented: $editViewPresented, content: {
                            
                            if let record = selectedRecord {
                                RecordDetailView(selectedModel: record)
                            }
                        })
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    RecordMainView()
}
