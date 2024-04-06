//
//  RecordDetailView.swift
//  simpleRecord
//
//  Created by MadCow on 2024/4/5.
//

import SwiftUI

struct RecordDetailView: View {
    
    @State var title: String = ""
    @State var date: String = ""
    @State var feelingImage: String = ""
    @State var content: String = ""
    @State var saveMode: Bool = false
    
    var body: some View {
        let backgroundColor: Color = self.saveMode ? Color.white : Color.gray.opacity(0.3)
        VStack {
            HStack {
                Text("제목")
                    .frame(height: 30)
                
                Spacer()
                
                TextField("", text: $title)
                    .frame(height: 30)
                    .overlay(RoundedRectangle(cornerRadius: 5)
                                 .stroke(Color.black, lineWidth: 1))
                    .background(backgroundColor)
//                    .background(Color.white)
                    .disabled(!saveMode)
                    
            }
            
            HStack {
                Text("날짜")
                    .frame(height: 30)
                
                Spacer()
                
                TextField("", text: $date)
                    .frame(height: 30)
                    .overlay(RoundedRectangle(cornerRadius: 5)
                                 .stroke(Color.black, lineWidth: 1))
                    .background(backgroundColor)
                    .disabled(!saveMode)
            }
            
            HStack {
                Text("기분")
                    .frame(height: 30)
                
                Spacer()
                
                TextField("", text: $feelingImage)
                    .frame(height: 30)
                    .overlay(RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.black, lineWidth: 1))
                    .background(backgroundColor)
//                    .background(Color.white)
                    .disabled(!saveMode)
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
                    .disabled(!saveMode)
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
                    saveMode.toggle()
                }, label: {
                    Text(saveMode ? "저장" : "편집")
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
    RecordDetailView()
}
