//
//  RecordMainView.swift
//  simpleRecord
//
//  Created by MadCow on 2024/4/4.
//

import SwiftUI



struct RecordMainView: View {
    
    private let recordMainViewModel = RecordMainViewModel()
    
    let data = (1...31).map{ "\($0)" }
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 7)
    let width: CGFloat = UIScreen.main.bounds.width / 7
    
    @State var currentYear: Int = 0
    @State var currentMonth: Int = 0
    
    init() {
        _currentYear = State(initialValue: recordMainViewModel.getCurrentYear())
        _currentMonth = State(initialValue: recordMainViewModel.getCurrentMonth())
    }
    
    var body: some View {
        
        VStack {
            HStack {
                HStack {
                    Button(action: {
                        decreaseMonth()
                    }, label: {
                        Image(systemName: "arrowtriangle.left.fill")
                            .foregroundStyle(Color.black)
                    })
                    
                    Text("\(String(currentYear))년 \(currentMonth)월")
                    
                    Button(action: {
                        increaseMonth()
                    }, label: {
                        Image(systemName: "arrowtriangle.right.fill")
                            .foregroundStyle(Color.black)
                    })
                }
                .padding(.horizontal)
                .padding(.top)
                
                
                Spacer()
                Button {
                    print("일기 쓰러 가자!")
                } label: {
                    Text("일기쓰기")
                        .padding()
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }
                .background(Capsule().fill(Color.blue))
                .padding(.horizontal)
            }
            .padding(.top)
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(data, id: \.self) { item in
                        VStack {
                            Spacer()
                            
                            Text(item)
                            
                            Spacer()
                            
                            Image(systemName: "sun.max.fill")
                            
                            Spacer()
                        }
                        .frame(width: width / 1.2, height: CGFloat(width * 1.5))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
                        )
                        .onTapGesture {
                            let currentDay = Int(item)!
                            let currentDate = "\(String(currentYear))-\(currentMonth)-\(currentDay)"
                            print(currentDate)
                        }
                    }
                }
                .padding()
            }
        }
    }
}

extension RecordMainView {
    func increaseYear() {
        currentYear += 1
    }
    
    func decreaseYear() {
        currentYear -= 1
    }
    
    func increaseMonth() {
        currentMonth += 1
        if currentMonth > 12 {
            increaseYear()
            currentMonth = 1
        }
    }
    
    func decreaseMonth() {
        currentMonth -= 1
        if currentMonth < 1 {
            decreaseYear()
            currentMonth = 12
        }
    }
}

#Preview {
    RecordMainView()
}
