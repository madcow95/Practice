//
//  TodoView.swift
//  Todo
//
//  Created by MadCow on 2024/4/13.
//

import SwiftUI

struct TodoView: View {
    
    private let viewModel: TodoViewModel = TodoViewModel()
    
    let dummy: [String] = ["a", "b", "c", "d", "e", "f", "g"]
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(dummy, id: \.self) { str in
                        NavigationLink(str) {
                            TodoDetailView(str: str)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    TodoView()
}
