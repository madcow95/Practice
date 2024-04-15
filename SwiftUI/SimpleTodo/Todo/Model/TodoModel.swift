//
//  TodoModel.swift
//  Todo
//
//  Created by MadCow on 2024/4/13.
//

import Foundation

struct TodoModel: Hashable {
    let uid: UUID = UUID()
    let date: String
    let title: String
    let description: String
}
