//
//  TodoModel.swift
//  ReactorKit_Todo
//
//  Created by MadCow on 2024/10/31.
//

import Foundation

struct Todo: Decodable {
    let title: String
    let content: String
    let imagePaths: [String]?
    let date: Date
    let viewCount: Int
    let todoReply: [TodoReply]
    
    enum CodingKeys: String, CodingKey {
        case title, content, imagePaths, date, viewCount, todoReply
    }
}

struct TodoReply: Decodable {
    let title: String
    let date: Date
    let writer: String
    
    enum CodingKeys: String, CodingKey {
        case title, date, writer
    }
}
