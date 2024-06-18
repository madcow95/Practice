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
    let rateCount: Double?
    let summary: String?
    let poster: String?
    let originalLanguage: String
    var bookmarked: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case releaseDate = "release_date"
        case rating = "vote_average"
        case rateCount = "vote_count"
        case summary = "overview"
        case poster = "poster_path"
        case originalLanguage = "original_language"
    }
}

@Model
class MovieInfoStorage {
    let id: Int
    let title: String
    let releaseDate: String
    let rating: Double?
    let rateCount: Double?
    let summary: String?
    let poster: String?
    let originalLanguage: String
    var bookmarked: Bool = false
    
    init(id: Int, title: String, releaseDate: String, rating: Double?, rateCount: Double?, summary: String?, poster: String?, originalLanguage: String, bookmarked: Bool) {
        self.id = id
        self.title = title
        self.releaseDate = releaseDate
        self.rating = rating
        self.rateCount = rateCount
        self.summary = summary
        self.poster = poster
        self.originalLanguage = originalLanguage
        self.bookmarked = bookmarked
    }
}
