//
//  MovieModel.swift
//  MovieApp
//
//  Created by MadCow on 2024/6/14.
//

import UIKit

struct Movie: Decodable {
    let page: Int?
    let result: [MovieInfo]
    
    enum CodingKeys: String, CodingKey {
        case page
        case result = "results"
    }
}

struct MovieInfo: Decodable {
    let id: Int
    let title: String
    let genreId: [Int]
    let releaseDate: String
    let rating: Double?
    let rateCount: Int?
    let summary: String?
    let poster: String?
    var posterImage: UIImage?
    
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
