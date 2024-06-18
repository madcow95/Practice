//
//  MovieModel.swift
//  MovieApp
//
//  Created by MadCow on 2024/6/14.
//

import Foundation
import SwiftData

struct Movie: Codable {
    let page: Int?
    let result: [MovieInfo]
    
    enum CodingKeys: String, CodingKey {
        case page
        case result = "results"
    }
}

struct MovieInfo: Codable {
    let id: Int
    let title: String
    let releaseDate: String
    let rating: Double?
    let summary: String?
    let poster: String?
    var bookmarked: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case releaseDate = "release_date"
        case rating = "vote_average"
        case summary = "overview"
        case poster = "poster_path"
    }
}

@Model
class MovieInfoStorage {
    let id: Int
    let title: String
    let releaseDate: String
    let rating: Double?
    let summary: String?
    let poster: String?
    var bookmarked: Bool = false
    
    init(id: Int, title: String, releaseDate: String, rating: Double?, summary: String?, poster: String?, bookmarked: Bool) {
        self.id = id
        self.title = title
        self.releaseDate = releaseDate
        self.rating = rating
        self.summary = summary
        self.poster = poster
        self.bookmarked = bookmarked
    }
}
