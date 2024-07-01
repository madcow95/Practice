//
//  MovieService.swift
//  MovieApp
//
//  Created by MadCow on 2024/6/27.
//

import UIKit
import Combine

class MovieService {
    
    private var movieKey: String? = nil
    private var youtubeKey: String? = nil
    
    init() {
        guard let movieAPIKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String,
              let youtubeAPIKey = Bundle.main.object(forInfoDictionaryKey: "YOUTUBE_KEY") as? String else {
            return
        }
        self.movieKey = movieAPIKey
        self.youtubeKey = youtubeAPIKey
    }
    
    func searchMovieBy(title: String) async throws -> AnyPublisher<[MovieInfo], Error> {
        let searchMovieUrlStr: String = "https://api.themoviedb.org/3/search/movie?query=\(title)&api_key=\(movieKey!)&language=ko_KR"
        guard let url = URL(string: searchMovieUrlStr) else {
            throw MovieSearchError.urlError
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap{ (data, response) in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw MovieSearchError.urlError
                }
                
                switch httpResponse.statusCode {
                case 400..<500:
                    throw MovieSearchError.searchValueInvalidError
                case 500..<600:
                    throw MovieSearchError.serviceNotExistError
                default:
                    break
                }
                
                let response = try JSONDecoder().decode(Movie.self, from: data)
                guard response.result.count != 0 else {
                    throw MovieSearchError.noResultError
                }
                return response.result.filter{ movie in
                    if movie.poster != nil && movie.rating != nil && !movie.releaseDate.isEmpty &&
                        movie.summary != nil {
                        return true
                    }
                    return false
                }
            }
            .share()
            .eraseToAnyPublisher()
    }
    
    func getPosterImage(posterURL: String) throws -> AnyPublisher<UIImage?, Error> {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(posterURL)") else {
            throw MovieSearchError.urlError
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap{ (data, _) in
                // MARK: TODO - response 에러처리
                return UIImage(data: data)
            }
            .removeDuplicates()
            .share()
            .eraseToAnyPublisher()
    }
}
