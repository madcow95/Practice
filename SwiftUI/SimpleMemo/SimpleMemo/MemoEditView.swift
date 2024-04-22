//
//  MemoEditView.swift
//  SimpleMemo
//
//  Created by MadCow on 2024/4/22.
//

import SwiftUI

struct CustomButton: View {
    
    var buttonName: String
    var buttonColor: Color
    var buttonAction: () -> Void
    
    var body: some View {
        Button(buttonName) {
            buttonAction()
        }
        .frame(width: 100, height: 25)
        .padding()
        .foregroundColor(.white)
        .background(buttonColor)
        .clipShape(Capsule())
    }
}

struct MemoEditView: View {
    
    @State private var title: String = ""
    @State private var date: String = ""
    @State private var editOrSave: String = "Edit"
    @State private var editMode: Bool = false
    
    @Binding var selectedMemo: Memo?
    @Binding var memoEditAppear: Bool
    
    var body: some View {
        VStack {
            TextField("제목", text: $title)
            TextField("날짜", text: $date)
                .disabled(true)
                .background(Color(UIColor.lightGray))
            
            Spacer()
            
            HStack {
                Spacer()
                
                CustomButton(buttonName: "Cancel", buttonColor: .red) {
                    memoEditAppear = false
                }
                
                Spacer()
                
                CustomButton(buttonName: editOrSave, buttonColor: .blue, buttonAction: {
                    if let selectMemo = selectedMemo {
                        selectMemo.title = title
                        selectMemo.date = date
                    }
                    
                    memoEditAppear = false
                })
                .disabled(title.isEmpty)
                
                Spacer()
            }
        }
        .onAppear {
            if let selectMemo = selectedMemo {
                title = selectMemo.title
            }
            date = Date().currentDateString
        }
        .padding()
    }
}
