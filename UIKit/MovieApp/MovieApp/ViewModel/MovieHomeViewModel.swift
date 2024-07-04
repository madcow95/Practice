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
    @Published var fetchMovieComplete: Bool = false
    @Published var thumbnailImage: UIImage? = nil
    @Published var thumbnailIsLoading: Bool = true
    // MARK: Error들 MovieService에 정의?
    @Published var errorType: MovieSearchError?
    @Published var errorMessage: String?
//    @Published var searchText: String?
    
    private let movieService = MovieService()
    private var cancellables = Set<AnyCancellable>()
    private var cancelleable: Cancellable?
    
//    private lazy var searchTextPublisher: AnyPublisher<[MovieInfo], Error> = {
//        $searchText
//            .debounce(for: 0.8, scheduler: RunLoop.main)
//            .removeDuplicates()
//            .compactMap{ $0 }
//            .tryMap{ self.searchMovi }
//            .share()
//            .eraseToAnyPublisher()
//    }()
    
    init() {
        $searchedMovies
            .compactMap{ $0.count > 0 }
            .removeDuplicates()
            .share()
            .eraseToAnyPublisher()
            .assign(to: &$fetchMovieComplete)
        
        $thumbnailImage
            .removeDuplicates()
            .map{ $0 == nil }
            .share()
            .eraseToAnyPublisher()
            .assign(to: &$thumbnailIsLoading)
        
        $errorType
            .removeDuplicates()
            .compactMap{ $0 }
            .map{ $0!.errorMessage }
            .share()
            .eraseToAnyPublisher()
            .assign(to: &$errorMessage)
    }
    
    func searchMovieBy(title: String) async {
        do {
            try await movieService.searchMovieBy(title: title)
                .sink { completion in
                    switch completion {
                    case .finished:
                        self.fetchMovieComplete = true
                        break
                    case .failure(let error):
                        if let movieError = error as? MovieSearchError {
                            self.errorType = movieError
                        } else {
                            self.errorMessage = error.localizedDescription
                        }
                    }
                } receiveValue: { [weak self] movies in
                    guard let self = self else { return }
                    
                    self.searchedMovies = movies
                }
                .store(in: &cancellables)
        } catch {
            if let movieError = error as? MovieSearchError {
                self.errorType = movieError
            } else {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func getThumbnailImage(posterURL: String) {
        do {
            try movieService.getPosterImage(posterURL: posterURL)
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        if let movieError = error as? MovieSearchError {
                            self.errorType = movieError
                        } else {
                            self.errorMessage = error.localizedDescription
                        }
                    }
                } receiveValue: { [weak self] poster in
                    guard let self = self else { return }
                    self.thumbnailImage = poster
                }
                .store(in: &cancellables)

        } catch {
            if let movieError = error as? MovieSearchError {
                self.errorType = movieError
            } else {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
