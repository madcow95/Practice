//
//  TodoView.swift
//  Todo
//
//  Created by MadCow on 2024/4/13.
//

import SwiftUI

struct TodoView: View {
    
    private let viewModel: TodoViewModel = TodoViewModel()
    
    @State var dummyDatas: [TodoModel] = TodoViewModel.getDummyData()
    @State var count: Int = 0
    @State var dummyIsEmpty: Bool = false
    
    init() {
        _dummyIsEmpty = State(initialValue: dummyDatas.count > 0)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(dummyDatas, id: \.self) { dummy in
                        NavigationLink(dummy.title) {
                            TodoDetailView(str: dummy.title)
                        }
                    }
                    .onDelete(perform: { indexSet in
                        dummyDatas.remove(atOffsets: indexSet)
                    })
                }
                .navigationTitle("List")
                .toolbar {
                    ToolbarItem {
                        Button {
                            removeDummy()
                            disableRemoveButton()
                        } label: {
                            Image(systemName: "minus.circle")
                        }
                        .disabled(dummyIsEmpty)
                    }
                    
                    ToolbarItem {
                        Button {
                            addDummy()
                            enableRemoveButton()
                        } label: {
                            Image(systemName: "plus.circle")
                        }
                    }
                }
            }
        }
    }
    
    func addDummy() {
//        dummyDatas.append("\(dummyDatas.count)")
    }
    
    func removeDummy() {
        if dummyDatas.count > 0 {
            dummyDatas.removeLast()
        } else {
            dummyIsEmpty = false
        }
    }
    
    func enableRemoveButton() {
        dummyIsEmpty = false
    }
    
    func disableRemoveButton() {
        if dummyDatas.count == 0 {
            dummyIsEmpty = true
        }
    }
}

#Preview {
    TodoView()
}
