//
//  VideoInfoModel.swift
//  CombineTest
//
//  Created by MadCow on 2024/5/9.
//

import Foundation

struct VideoDocument: Codable {
    let documents: [VideoInfoModel]
}

struct VideoInfoModel: Codable {
    let title: String
    let url: String
    let thumbnail: String
    let author: String
}
