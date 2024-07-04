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
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        guard let movieAPIKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String,
              let youtubeAPIKey = Bundle.main.object(forInfoDictionaryKey: "YOUTUBE_KEY") as? String else {
            return
        }
        self.movieKey = movieAPIKey
        self.youtubeKey = youtubeAPIKey
    }
    
    func searchMovieBy(title: String) throws -> AnyPublisher<[MovieInfo], Error> {
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
                // 포스터나 영화에 대한 정보가 없으면 return
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
    
    func fetchVideo(title: String?) throws -> AnyPublisher<[Trailer], Error> {
        guard let title = title else {
            throw MovieSearchError.noTitleError
        }
        let movieTitle = title.components(separatedBy: "제목: ")[1]
        let query = "\(movieTitle)trailer"
        
        let urlStr = "https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=5&q=\(query)&key=\(youtubeKey!)"
        guard let videoURL = URL(string: urlStr) else {
            throw MovieSearchError.noResultError
        }
        
        return URLSession.shared.dataTaskPublisher(for: videoURL)
            .receive(on: DispatchQueue.global())
            .tryMap{ (data, _) in
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                    throw MovieSearchError.noResultError
                }
                // JSONDecoder로 decode가 잘 안되서 이렇게 진행
                var movieItems: [Trailer] = []
                if let items = json["items"] as? [[String: Any]] {
                    for item in items {
                        if let snippet = item["snippet"] as? [String: Any],
                           let thumbnails = snippet["thumbnails"] as? [String: Any],
                           let defaultThumbnail = thumbnails["default"] as? [String: Any],
                           let thumbnailURLString = defaultThumbnail["url"] as? String,
                           let thumbnailHeight = defaultThumbnail["height"] as? Int,
                           let thumbnailWidth = defaultThumbnail["width"] as? Int,
                           let id = item["id"] as? [String: Any],
                           let videoId = id["videoId"] as? String
                        {
                            movieItems.append(Trailer(videoID: videoId, url: thumbnailURLString, width: thumbnailWidth, height: thumbnailHeight))
                            break
                        }
                    }
                }
                if movieItems.count == 0 {
                    throw MovieSearchError.noResultError
                }
                return movieItems
            }
            .eraseToAnyPublisher()
    }
}
