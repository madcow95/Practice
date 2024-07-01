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
    @Published var isLoading: Bool = true
    
    private let movieService = MovieService()
    private var cancellables = Set<AnyCancellable>()
    private var cancelleable: Cancellable?
    
    init() {
        $searchedMovies
            .map{ $0.count > 0 }
            .removeDuplicates()
            .share()
            .eraseToAnyPublisher()
            .assign(to: &$fetchMovieComplete)
        
        $thumbnailImage
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .map{ $0 == nil }
            .share()
            .eraseToAnyPublisher()
            .assign(to: &$isLoading)
    }
    
    func searchMovieBy(title: String) async {
        do {
            try await movieService.searchMovieBy(title: title)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("error in sink >> \(error)")
                    }
                } receiveValue: { [weak self] movies in
                    guard let self = self else { return }
                    self.searchedMovies = movies
                }
                .store(in: &cancellables)
        } catch {
            print(error)
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
                        print(error.localizedDescription)
                    }
                } receiveValue: { [weak self] poster in
                    guard let self = self else { return }
                    self.thumbnailImage = poster
                }
                .store(in: &cancellables)

        } catch {
            print(error)
        }
    }
}
