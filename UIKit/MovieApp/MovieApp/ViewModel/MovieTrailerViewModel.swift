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
        do {
            try movieService.fetchVideo(title: title)
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
        } catch {
            print(error)
        }
    }
}
