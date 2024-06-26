//
//  MovieHomeViewModel.swift
//  MovieApp
//
//  Created by MadCow on 2024/6/14.
//

import UIKit
import Combine

class MovieHomeViewModel {
    @Published var searchedMovies: [MovieInfo] = []
    @Published var thumbnailImage: UIImage? = nil
    @Published var isLoading: Bool = true
    
    private var cancellables = Set<AnyCancellable>()
    private var cancelleable: Cancellable?
    var movieTableReloadDelegate: ReloadMovieTableDelegate?
    
    private lazy var isLoadingPublisher: AnyPublisher<Bool, Never> = {
        $thumbnailImage
            .removeDuplicates()
            .map{ $0 == nil }
            .share()
            .eraseToAnyPublisher()
    }()
    
    init() {
        // MARK: - @Published빼고.. searchedMovies의 didSet에 넣어줘도 같은거 아닌가..? reloadData를 하지 않고도 UI를 다시 그릴 수 있는 방법이 있나?
        cancelleable?.cancel()
        cancelleable = self.$searchedMovies.sink { [weak self] _ in
            DispatchQueue.main.async {
                self?.movieTableReloadDelegate?.reloadTableView()
            }
        }
        
        isLoadingPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: &$isLoading)
    }
    
    func searchMovieBy(name: String) async throws {
        // MARK: 띄어쓰기 틀리면 검색이 안됨..
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            throw MovieSearchError.apiKeyError
        }
        let searchMovieUrlStr: String = "https://api.themoviedb.org/3/search/movie?query=\(name)&api_key=\(apiKey)&language=ko_KR"
        
        guard let url = URL(string: searchMovieUrlStr) else { return }
        
        let (searchResult, urlResponse) = try await URLSession.shared.data(from: url)
        guard let httpResponse = urlResponse as? HTTPURLResponse else {
            throw MovieSearchError.urlError
        }
        switch httpResponse.statusCode {
        case 400..<500:
            searchedMovies = []
            throw MovieSearchError.searchValueInvalidError
        case 500..<600:
            searchedMovies = []
            throw MovieSearchError.serviceNotExistError
        default:
            break
        }
        
        do {
            let decoder = JSONDecoder()
            let response = try decoder.decode(Movie.self, from: searchResult)
            
            guard response.result.count != 0 else {
                searchedMovies = []
                throw MovieSearchError.noResultError
            }
            
            // 빈 데이터 filter
            self.searchedMovies = response.result.filter{ movie in
                if movie.poster != nil && movie.rating != nil && !movie.releaseDate.isEmpty &&
                    movie.summary != nil {
                    return true
                }
                return false
            }
        } catch {
//            throw error
        }
    }
    
    func getThumbnailImage(posterUrl: String) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(posterUrl)") else { return }
        
        // MARK: 여기도 .receive(on: DispatchQueue.main)?
        URLSession.shared.dataTaskPublisher(for: url)
            .map { data, _ in UIImage(data: data)! }
            .replaceError(with: UIImage(systemName: "exclamationmark.triangle")!)
            .receive(on: DispatchQueue.main)
            .assign(to: &$thumbnailImage)
    }
}
