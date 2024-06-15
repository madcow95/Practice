//
//  MovieHomeViewModel.swift
//  MovieApp
//
//  Created by MadCow on 2024/6/14.
//

import Foundation
import Combine

class MovieHomeViewModel {
    private let movieKey: String = "74632d0636eed1fd804303a83e5e942f"
    @Published var searchedMovies: MovieResponse = MovieResponse(page: nil, result: [])
    
    func searchMovieBy(name: String) async throws {
        let searchMovieUrlStr: String = "https://api.themoviedb.org/3/search/movie?query=\(name)&api_key=\(movieKey)&language=ko_KR"
        
        guard let url = URL(string: searchMovieUrlStr) else { return }
        
        let (searchResult, urlResponse) = try await URLSession.shared.data(from: url)
        guard let httpResponse = urlResponse as? HTTPURLResponse else { return }
        switch httpResponse.statusCode {
        case 400..<500:
            print(MovieSearchError.searchValueInvalidError)
            return
        case 500..<600:
            print(MovieSearchError.serviceNotExistError)
            return
        default:
            break
        }
        
        do {
            let decoder = JSONDecoder()
            let respons = try decoder.decode(MovieResponse.self, from: searchResult)
            guard respons.result.count != 0 else {
                print(MovieSearchError.noResultError)
                return
            }

            self.searchedMovies = respons
        } catch let error {
            print(error.localizedDescription)
        }
        
//        let sessionRequest = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
//            guard error == nil else { return }
//            
//            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }
//            switch statusCode {
//            case 400..<500:
//                print(MovieSearchError.searchValueInvalidError)
//                return
//            case 500..<600:
//                print(MovieSearchError.serviceNotExistError)
//                return
//            default:
//                break
//            }
//            
//            guard let resultData = data else { return }
//            
//            do {
//                let decoder = JSONDecoder()
//                let respons = try decoder.decode(MovieResponse.self, from: resultData)
//                print(respons)
//                guard respons.result.count != 0 else {
//                    print(MovieSearchError.noResultError)
//                    return
//                }
//                
//                let searchedMovies = respons.result
//                self.searchedMovies = searchedMovies.map{ $0.title }
//                
//            } catch let error {
//                print(error.localizedDescription)
//            }
//        }
//        
//        sessionRequest.resume()
    }
}
