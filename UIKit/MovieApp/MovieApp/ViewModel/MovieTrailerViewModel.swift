//
//  MovieTrailerViewModel.swift
//  MovieApp
//
//  Created by MadCow on 2024/6/26.
//

import Foundation
import Combine

class MovieTrailerViewModel {
    
    @Published var videos: [Item] = []
    private var cancellables = Set<AnyCancellable>()
    
    func fetchVideo(title: String?) {
        guard let title = title else { return }
        let movieTitle = title.components(separatedBy: "제목: ")[1]
        print(movieTitle)
        let apiKey = "AIzaSyBlxKZcn0NogbYdXGU3YN9na9c4k33Viqs"
        let query = "\(movieTitle)trailer"
        
        let urlStr = "https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=1&order=viewCount&q=\(query)&key=\(apiKey)"
        guard let videoURL = URL(string: urlStr) else {
            print("video url no exist")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: videoURL)
            .receive(on: DispatchQueue.main)
            .tryMap{ (data, _) in
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                    print("JSONSerialization fail")
                    fatalError("JSONSerialization fail")
                }
                // JSONDecoder로 decode가 잘 안되서 이렇게 진행
                var movieItems: [Item] = []
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
                            
                            movieItems.append(Item(id: ID(videoID: videoId),
                                                   snippet: Snippet(thumbnails:
                                                                        Thumbnails(thumbnailsDefault:
                                                                                    Default(url: thumbnailURLString,
                                                                                            width: thumbnailHeight,
                                                                                            height: thumbnailWidth)))))
                        }
                    }
                }
                if movieItems.count == 0 {
                    throw MovieSearchError.noResultError
                }
                return movieItems
            }
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { [weak self] items in
                guard let self = self else { return }
                self.videos = items
            }
            .store(in: &cancellables)
    }
}
