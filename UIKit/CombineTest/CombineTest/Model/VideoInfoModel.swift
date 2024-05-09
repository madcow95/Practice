//
//  VideoInfoModel.swift
//  CombineTest
//
//  Created by MadCow on 2024/5/9.
//

import Foundation

class VideoInfoModel {
    let title: String
    let url: String
    let thumbnail: String
    let author: String
    
    init(title: String, url: String, thumbnail: String, author: String) {
        self.title = title
        self.url = url
        self.thumbnail = thumbnail
        self.author = author
    }
}
