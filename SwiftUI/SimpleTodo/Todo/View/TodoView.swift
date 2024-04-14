//
//  TodoView.swift
//  Todo
//
//  Created by MadCow on 2024/4/13.
//

import SwiftUI

struct TodoView: View {
    
    private let viewModel: TodoViewModel = TodoViewModel()
    
    @State var dummy: [String] = []
    @State var count: Int = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(dummy, id: \.self) { str in
                        NavigationLink(str) {
                            TodoDetailView(str: str)
                        }
                    }
                    .onDelete(perform: { indexSet in
                        dummy.remove(atOffsets: indexSet)
                    })
                }
                .navigationTitle("List")
                .toolbar {
                    ToolbarItem {
                        Button {
                            
                        } label: {
                            Image(systemName: "minus.circle")
                        }
                    }
                    
                    ToolbarItem {
                        Button {
                            addDummy()
                        } label: {
                            Image(systemName: "plus.circle")
                        }
                    }
                }
            }
        }
    }
    
    func addDummy() {
        self.dummy.append("\(count)")
        count += 1
    }
}

#Preview {
    TodoView()
}
