//
//  MovieDetailView.swift
//  MovieApp
//
//  Created by MadCow on 2024/6/17.
//

import UIKit
import Combine

// TODO: 주석 한 번 작성해보기
class MovieDetailView: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        
        return scroll
    }()
    
    private let contentView: UIView = {
        let content = UIView()
        content.translatesAutoresizingMaskIntoConstraints = false
        
        return content
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        return label
    }()
    
    private let openDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let rateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let posterImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    private let summaryTextView: UILabel = {
        let tv = UILabel()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        tv.numberOfLines = 0
        
        return tv
    }()
    
    var selectedMovie: MovieInfo?
    private var cancellable: Cancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setScrollView()
        configureUI()
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
    
    func configureUI() {
        guard let selectedMovie = selectedMovie else { return }
        
        titleLabel.text = "제목: \(selectedMovie.title)"
        openDateLabel.text = "개봉일: \(selectedMovie.releaseDate)"
        if let rating = selectedMovie.rating {
            rateLabel.text = "평점: \(rating)점"
        }
        if let poster = selectedMovie.poster, let url = URL(string: "https://image.tmdb.org/t/p/w500/\(poster)") {
            // TODO: ViewModel에서 처리?
            cancellable?.cancel()
            cancellable = URLSession.shared.dataTaskPublisher(for: url)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("error while load poster image > \(error.localizedDescription)")
                    }
                }, receiveValue: { (imageData, _) in
                    let poster = UIImage(data: imageData)
                    DispatchQueue.main.async {
                        self.posterImage.image = poster
                    }
                })
        }
        if let summary = selectedMovie.summary {
            summaryTextView.text = "내용:\n\(summary)"
        }
        
        [titleLabel, openDateLabel, rateLabel, posterImage, summaryTextView].forEach{ contentView.addSubview($0) }
        
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
            
            summaryTextView.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 20),
            summaryTextView.leadingAnchor.constraint(equalTo: posterImage.leadingAnchor),
            summaryTextView.trailingAnchor.constraint(equalTo: posterImage.trailingAnchor),
            summaryTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
