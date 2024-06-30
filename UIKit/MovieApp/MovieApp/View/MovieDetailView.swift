//
//  MovieDetailView.swift
//  MovieApp
//
//  Created by MadCow on 2024/6/17.
//

import UIKit
import Combine

class MovieDetailView: UIViewController {
    
    // UI Components
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let titleLabel = UILabel()
    private let openDateLabel = UILabel()
    private let rateLabel = UILabel()
    private let posterImage = UIImageView()
    private lazy var trailerButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("예고편 보기", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.addAction(UIAction{ [weak self] _ in
            guard let self = self else { return }
            let trailerView = MovieTrailerView()
            trailerView.movieTitle = self.titleLabel.text
            present(trailerView, animated: true)
        }, for: .touchUpInside)
        
        return btn
    }()
    private let summaryLabel = UILabel()
    
    private var cancellable = Set<AnyCancellable>()
    private let detailViewModel = MovieDetailViewModel()
    var selectedMovie: MovieInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setSubscriber()
        configureUI()
    }
    
    
    func configureUI() {
        [scrollView, contentView, titleLabel, openDateLabel, rateLabel,
         posterImage, summaryLabel].forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
        titleLabel.numberOfLines = 0
        posterImage.contentMode = .scaleAspectFit
        summaryLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        summaryLabel.numberOfLines = 0
        
        // scroll view 세팅
        setScrollView()
        guard let selectedMovie = selectedMovie else { return }
        
        titleLabel.text = "제목: \(selectedMovie.title)"
        openDateLabel.text = "개봉일: \(selectedMovie.releaseDate)"
        if let rating = selectedMovie.rating,
           let rateCount = selectedMovie.rateCount,
           let poster = selectedMovie.poster,
           let summary = selectedMovie.summary {
            
            detailViewModel.fetchPosterImage(poster: poster)
            
            rateLabel.text = "평점: \(rating)점 (\(rateCount))"
            if !summary.isEmpty {
                summaryLabel.text = "내용:\n\(summary)"
            }
        }
        
        [titleLabel, openDateLabel, rateLabel, posterImage, trailerButton, summaryLabel].forEach{ contentView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            openDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            openDateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            openDateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            rateLabel.topAnchor.constraint(equalTo: openDateLabel.bottomAnchor, constant: 20),
            rateLabel.leadingAnchor.constraint(equalTo: openDateLabel.leadingAnchor),
            rateLabel.trailingAnchor.constraint(equalTo: openDateLabel.trailingAnchor),
            
            posterImage.topAnchor.constraint(equalTo: rateLabel.bottomAnchor, constant: 20),
            posterImage.leadingAnchor.constraint(equalTo: rateLabel.leadingAnchor),
            posterImage.trailingAnchor.constraint(equalTo: rateLabel.trailingAnchor),
            posterImage.heightAnchor.constraint(equalToConstant: 500),
            
            trailerButton.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 10),
            trailerButton.leadingAnchor.constraint(equalTo: posterImage.leadingAnchor),
            trailerButton.trailingAnchor.constraint(equalTo: posterImage.trailingAnchor),
            
            summaryLabel.topAnchor.constraint(equalTo: trailerButton.bottomAnchor, constant: 10),
            summaryLabel.leadingAnchor.constraint(equalTo: posterImage.leadingAnchor),
            summaryLabel.trailingAnchor.constraint(equalTo: posterImage.trailingAnchor),
            summaryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    func setScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor)
        ])
    }
    
    func setSubscriber() {
        detailViewModel.$posterImage
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: posterImage)
            .store(in: &cancellable)
    }
}
