//
//  MovieTrailerViewModel.swift
//  MovieApp
//
//  Created by MadCow on 2024/6/26.
//

import Foundation
import Combine

class MovieTrailerViewModel {
    
    @Published var trailerVideo: Trailer? = nil
    private let movieService = MovieService()
    private var cancellables = Set<AnyCancellable>()
    
    func fetchVideo(title: String?) {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "YOUTUBE_KEY") as? String else { return }
        guard let title = title else { return }
        let movieTitle = title.components(separatedBy: "제목: ")[1]
        let query = "\(movieTitle)trailer"
        
        let urlStr = "https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=5&q=\(query)&key=\(apiKey)"
        guard let videoURL = URL(string: urlStr) else {
            print("video url no exist")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: videoURL)
            .receive(on: DispatchQueue.main)
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
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("error > \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] trailers in
                guard let self = self else { return }
                if trailers.count > 0, let trailer = trailers.first {
                    self.trailerVideo = trailer
                }
            }
            .store(in: &cancellables)
    }
}

// Search
//private func setupSearchController() {
//    searchController.searchResultsUpdater = self
//    searchController.obscuresBackgroundDuringPresentation = false
//    searchController.searchBar.placeholder = "코인이름을 검색해주세요."
//    searchController.hidesNavigationBarDuringPresentation = false
//    
//    navigationItem.hidesSearchBarWhenScrolling = false
//    
//    navigationItem.searchController = searchController
//    definesPresentationContext = true
//}
