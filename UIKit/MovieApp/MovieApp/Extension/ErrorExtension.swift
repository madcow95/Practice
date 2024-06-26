//
//  ErrorExtension.swift
//  MovieApp
//
//  Created by MadCow on 2024/6/15.
//

import UIKit

enum MovieSearchError: Error {
    case apiKeyError
    case urlError
    case searchValueInvalidError
    case serviceNotExistError
    case noResultError
    case decodingError
    case posterLoadError
    
    var errorMessage: String {
        get {
            switch self {
            case .apiKeyError:
                return "잘못된 API Key입니다."
            case .urlError:
                return "잘못된 URL입니다."
            case .serviceNotExistError:
                return "서비스가 존재하지 않습니다."
            case .searchValueInvalidError:
                return "검색 url이 잘못되었습니다(url, sort)"
            case .noResultError:
                return "검색 결과가 없습니다."
            case .decodingError:
                return "디코딩 중 에러가 발생했습니다."
            case .posterLoadError:
                return "이미지를 불러오는 중 에러가 발생했습니다."
            }
        }
    }
}
