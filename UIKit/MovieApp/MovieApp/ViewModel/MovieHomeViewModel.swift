//
//  MovieHomeViewModel.swift
//  MovieApp
//
//  Created by MadCow on 2024/6/14.
//

import Foundation
import Combine
import SwiftData

class MovieHomeViewModel {
    @Published var searchedMovies: [MovieInfo] = []
    private let movieKey: String = "74632d0636eed1fd804303a83e5e942f"
    private var cancelleable: Cancellable?
    var movieTableReloadDelegate: ReloadMovieTableDelegate?
    
    init() {
        // MARK: - @Published빼고.. searchedMovies의 didSet에 넣어줘도 같은거 아닌가..? reloadData를 하지 않고도 UI를 다시 그릴 수 있는 방법이 있나?
        cancelleable?.cancel()
        cancelleable = self.$searchedMovies.sink { [weak self] _ in
            DispatchQueue.main.async {
                self?.movieTableReloadDelegate?.reloadTableView()
            }
        }
    }
    
    func searchMovieBy(name: String) async throws {
        // MARK: 띄어쓰기 틀리면 검색이 안됨..
        let searchMovieUrlStr: String = "https://api.themoviedb.org/3/search/movie?query=\(name)&api_key=\(movieKey)&language=ko_KR"
        
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
            
            self.searchedMovies = response.result
        } catch let error {
            throw error
        }
    }
}
