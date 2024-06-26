//
//  TrailerModel.swift
//  MovieApp
//
//  Created by MadCow on 2024/6/26.
//

import Foundation

// MARK: - Welcome
struct TrailerModel: Codable {
    let nextPageToken, regionCode: String
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let kind, etag: String
    let id: ID
    let snippet: Snippet
}

// MARK: - ID
struct ID: Codable {
    let kind, videoId: String

    enum CodingKeys: String, CodingKey {
        case kind
        case videoId
    }
}

// MARK: - Snippet
struct Snippet: Codable {
    let publishedAt: Date
    let channelId, title, description: String
    let thumbnails: Thumbnails
    let channelTitle, liveBroadcastContent: String
    let publishTime: Date

    enum CodingKeys: String, CodingKey {
        case publishedAt
        case channelId
        case title, description, thumbnails, channelTitle, liveBroadcastContent, publishTime
    }
}

// MARK: - Thumbnails
struct Thumbnails: Codable {
    let thumbnailsDefault, medium, high: Default

    enum CodingKeys: String, CodingKey {
        case thumbnailsDefault = "default"
        case medium, high
    }
}

// MARK: - Default
struct Default: Codable {
    let url: String
    let width, height: Int
}
