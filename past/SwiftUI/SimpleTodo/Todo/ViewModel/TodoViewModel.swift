//
//  TodoViewModel.swift
//  Todo
//
//  Created by MadCow on 2024/4/13.
//

import Foundation

class TodoViewModel {
    static func getDummyData() -> [TodoModel] {
        return [
            TodoModel(date: "2024-4-15", title: "Dummy Title 1", description: "Dummy Description 1"),
            TodoModel(date: "2024-4-17", title: "Dummy Title 2", description: "Dummy Description 2"),
            TodoModel(date: "2024-4-18", title: "Dummy Title 3", description: "Dummy Description 3"),
            TodoModel(date: "2024-4-24", title: "Dummy Title 4", description: "Dummy Description 4"),
            TodoModel(date: "2024-4-27", title: "Dummy Title 5", description: "Dummy Description 5")
        ]
    }
}
