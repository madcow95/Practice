//
//  TrailerModel.swift
//  MovieApp
//
//  Created by MadCow on 2024/6/26.
//

import Foundation

// MARK: - Item
struct Item: Codable {
    let id: ID
    let snippet: Snippet
}

// MARK: - ID
struct ID: Codable {
    let videoID: String
}

// MARK: - Snippet
struct Snippet: Codable {
    let thumbnails: Thumbnails
}

// MARK: - Thumbnails
struct Thumbnails: Codable {
    let thumbnailsDefault: Default
}

// MARK: - Default
struct Default: Codable {
    let url: String
    let width, height: Int
}
