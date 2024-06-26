//
//  MovieModel.swift
//  MovieApp
//
//  Created by MadCow on 2024/6/14.
//

import Foundation

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
    let genreId: [Int]
    let releaseDate: String
    let rating: Double?
    let rateCount: Int?
    let summary: String?
    let poster: String?
    var bookmarked: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case genreId = "genre_ids"
        case releaseDate = "release_date"
        case rating = "vote_average"
        case rateCount = "vote_count"
        case summary = "overview"
        case poster = "poster_path"
    }
}
