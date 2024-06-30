//
//  TrailerModel.swift
//  MovieApp
//
//  Created by MadCow on 2024/6/26.
//

import Foundation

struct Trailer: Decodable {
    let videoID, url: String
    let width, height: Int
}
