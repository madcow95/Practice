//
//  SearchResultModel.swift
//  CombineTest
//
//  Created by MadCow on 2024/5/9.
//

import Foundation

// MARK: - Welcome
struct Document: Codable {
    let documents: [Contents]
}

// MARK: - Document
struct Contents: Codable {
    let contents, datetime, title: String
    let url: String
}
