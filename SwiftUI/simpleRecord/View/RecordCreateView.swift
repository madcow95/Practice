//
//  RecordCreateView.swift
//  simpleRecord
//
//  Created by MadCow on 2024/4/5.
//

import SwiftUI

struct RecordCreateView: View {
    
    @State var title: String = ""
    @State var date: String = ""
    @State var feelingImage: String = ""
    @State var content: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Text("제목")
                    .frame(height: 30)
                
                Spacer()
                
                TextField("", text: $title)
                    .frame(height: 30)
                    .overlay(RoundedRectangle(cornerRadius: 5)
                                 .stroke(Color.black, lineWidth: 1))
                    .background(Color.white)
                    
            }
            
            HStack {
                Text("날짜")
                    .frame(height: 30)
                
                Spacer()
                
                TextField("", text: $date)
                    .frame(height: 30)
                    .overlay(RoundedRectangle(cornerRadius: 5)
                                 .stroke(Color.black, lineWidth: 1))
                    .background(Color.gray.opacity(0.3))
                    .textScale(.default, isEnabled: false)
                    .disabled(true)
            }
            
            HStack {
                Text("기분")
                    .frame(height: 30)
                
                Spacer()
                
                TextField("", text: $feelingImage)
                    .frame(height: 30)
                    .overlay(RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.black, lineWidth: 1))
                    .background(Color.white)
            }
            
            VStack {
                HStack {
                    Text("내용")
                        .frame(height: 30)
                    Spacer()
                }
                
                TextEditor(text: $content)
                    .overlay(RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.black, lineWidth: 1))
                    .padding(.bottom, 20)
            }
            
            Spacer()
            
            HStack {
                Spacer()
                
                Button(action: {
                    
                }, label: {
                    Text("취소")
                })
                .frame(width: 150, height: 40)
                .overlay(RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.black, lineWidth: 1))
                
                Spacer()
                
                Button(action: {
                    
                }, label: {
                    Text("저장")
                })
                .frame(width: 150, height: 40)
                .overlay(RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.black, lineWidth: 1))
                .background(Color.blue)
                .tint(Color.white)
                
                Spacer()
            }
        }
        .padding()
    }
}

#Preview {
    RecordCreateView()
}
