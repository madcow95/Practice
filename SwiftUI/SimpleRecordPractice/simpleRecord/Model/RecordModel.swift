//
//  RecordModel.swift
//  simpleRecord
//
//  Created by MadCow on 2024/4/4.
//

import SwiftData
import Combine

class RecordModel {
    var title: String
    var date: String
    var feelingImage: String
    var content: String
    
    init(title: String, date: String, feelingImage: String, content: String) {
        self.title = title
        self.date = date
        self.feelingImage = feelingImage
        self.content = content
    }
}
