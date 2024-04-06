//
//  RecordModel.swift
//  simpleRecord
//
//  Created by MadCow on 2024/4/4.
//

import SwiftData

@Model
class RecordModel {
    @Attribute(.unique) let date: String
    let title: String
    let feelingImage: String
    let content: String
    
    init(title: String, date: String, feelingImage: String, content: String) {
        self.title = title
        self.date = date
        self.feelingImage = feelingImage
        self.content = content
    }
}
