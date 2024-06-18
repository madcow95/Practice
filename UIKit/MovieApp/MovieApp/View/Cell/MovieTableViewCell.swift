//
//  MovieTableViewCell.swift
//  MovieApp
//
//  Created by MadCow on 2024/6/17.
//

import UIKit
import Combine

class MovieTableViewCell: UITableViewCell {
    
    private var cancellable: Cancellable?
    var homeViewModel = MovieHomeViewModel()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        
        return label
    }()
    
    private let thumbnailImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        
        return image
    }()
    
    private let bookmarkButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(movie: MovieInfo) {
        let title = movie.title
        titleLabel.text = title
        
        if let poster = movie.poster, let url = URL(string: "https://image.tmdb.org/t/p/w500/\(poster)") {
            self.addSubview(thumbnailImage)
            
            // TODO: ViewModel에서 처리?
            cancellable?.cancel()
            cancellable = URLSession.shared.dataTaskPublisher(for: url)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("error in image load > \(error)")
                    }
                } receiveValue: { [weak self] (data, _) in
                    guard let self = self else { return }
                    let posterImage = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.thumbnailImage.image = posterImage
                    }
                }
            
            NSLayoutConstraint.activate([
                thumbnailImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                thumbnailImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
                thumbnailImage.widthAnchor.constraint(equalToConstant: 90),
                thumbnailImage.heightAnchor.constraint(equalToConstant: 90)
            ])
        }
        /*
        bookmarkButton.addAction(UIAction{ [weak self] _ in
            guard let self = self else { return }
            let newMovie = MovieInfoStorage(id: movie.id,
                                            title: movie.title,
                                            releaseDate: movie.releaseDate,
                                            rating: movie.rating,
                                            summary: movie.summary,
                                            poster: movie.poster, bookmarked: true)
            homeViewModel.saveMovie(movie: newMovie)
        }, for: .touchUpInside)
        */
        
        self.addSubview(titleLabel)
        
//        self.addSubview(bookmarkButton)
//        bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 110),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            /*
            bookmarkButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            bookmarkButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            */
        ])
    }
}
