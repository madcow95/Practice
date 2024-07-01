//
//  MovieDetailViewModel.swift
//  MovieApp
//
//  Created by MadCow on 2024/6/17.
//

import UIKit
import Combine

class MovieDetailViewModel {
    @Published var posterImage: UIImage? = nil
    private var cancellable = Set<AnyCancellable>()
    private let movieService = MovieService()
    
    func fetchPosterImage(poster: String) {
        do {
            try movieService.getPosterImage(posterURL: poster)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("error in fetchPosterImage > \(error.localizedDescription)")
                    }
                } receiveValue: { [weak self] poster in
                    guard let self = self else { return }
                    self.posterImage = poster
                }
                .store(in: &cancellable)
        } catch {
            print("error in fetchPosterImage catch >> \(error.localizedDescription)")
        }
    }
}
