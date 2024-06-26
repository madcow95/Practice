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
    
    func fetchPosterImage(poster: String) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(poster)") else { return }
        
        // MARK: TODO - response등 error alert처리
        URLSession.shared.dataTaskPublisher(for: url)
            .map{ (data, _) in
                return UIImage(data: data)
            }
            .share()
            .eraseToAnyPublisher()
            .removeDuplicates()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("error while load poster image > \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] image in
                guard let self = self else { return }
                self.posterImage = image
            }
            .store(in: &cancellable)
    }
}
