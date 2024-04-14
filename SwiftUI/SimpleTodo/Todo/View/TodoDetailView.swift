//
//  TodoDetailView.swift
//  Todo
//
//  Created by MadCow on 2024/4/13.
//

import SwiftUI

struct TodoDetailView: View {
    
    @State var str: String = ""
    @State var textFieldIsDisable: Bool = true
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("입력하세요", text: $str)
                    .clipShape(.capsule)
                    .padding()
                    .disabled(textFieldIsDisable)
                    .border(Color.black, width: 1)
                    .background(textFieldIsDisable ? .gray : .white)
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        textFieldIsDisable.toggle()
                        textFieldIsDisable ? saveText() : cancelSave()
                    } label: {
                        Text(textFieldIsDisable ? "Edit" : "Save")
                    }
                }
            }
        }
        .padding()
    }
    
    func saveText() {
        
    }
    
    func cancelSave() {
//        textFieldIsDisable = true
    }
}

#Preview {
    TodoDetailView()
}
