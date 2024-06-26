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
