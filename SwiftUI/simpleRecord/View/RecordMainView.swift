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
    
    var body: some View {
        
        VStack {
            HStack {
                HStack {
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "arrowtriangle.left.fill")
                            .foregroundStyle(Color.black)
                    })
                    
                    Text("4월")
                    
                    Button(action: {
                        
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
                            print(item)
                        }
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
