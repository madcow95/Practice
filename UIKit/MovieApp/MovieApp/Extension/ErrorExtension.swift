//
//  ErrorExtension.swift
//  MovieApp
//
//  Created by MadCow on 2024/6/15.
//

import Foundation

enum MovieSearchError: Error {
    case urlError
    case searchValueInvalidError
    case serviceNotExistError
    case noResultError
    case decodingError
}
