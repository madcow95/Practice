//
//  MovieTableViewCell.swift
//  MovieApp
//
//  Created by MadCow on 2024/6/17.
//

import UIKit
import Combine

class MovieTableViewCell: UITableViewCell {
    
    private var cancellable = Set<AnyCancellable>()
    private let viewModel = MovieHomeViewModel()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        
        return label
    }()
    
    private lazy var thumbnailImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        return indicator
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
        
        if let poster = movie.poster, !poster.isEmpty {
            setSubscriber(poster: poster)
            contentView.addSubview(thumbnailImage)
            contentView.addSubview(activityIndicator)
            
            NSLayoutConstraint.activate([
                thumbnailImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                thumbnailImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
                thumbnailImage.widthAnchor.constraint(equalToConstant: 90),
                thumbnailImage.heightAnchor.constraint(equalToConstant: 90),
                
                activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                activityIndicator.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
                activityIndicator.widthAnchor.constraint(equalToConstant: 90),
                activityIndicator.heightAnchor.constraint(equalToConstant: 90)
            ])
        } else {
            // poster가 없을 때 ProgressView -> 영화 데이터를 불러올 때 데이터들이 없으면 filter를 했지만 혹시 몰라서 남겨둠
            contentView.addSubview(activityIndicator)
            
            NSLayoutConstraint.activate([
                 activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                 activityIndicator.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
                 activityIndicator.widthAnchor.constraint(equalToConstant: 90),
                 activityIndicator.heightAnchor.constraint(equalToConstant: 90)
            ])
        }

        self.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 110),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
    
    func setSubscriber(poster: String) {
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                guard let self = self else { return }
                self.activityIndicator.isHidden = !isLoading
                if isLoading {
                    self.activityIndicator.startAnimating()
                } else {
                    self.activityIndicator.stopAnimating()
                }
            }
            .store(in: &cancellable)
        
        viewModel.$thumbnailImage
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: thumbnailImage)
            .store(in: &cancellable)
        
        viewModel.getThumbnailImage(posterURL: poster)
    }
    
    // 셀이 재사용되기 전에 호출되어 셀의 상태를 초기화하는 역할
    // 초기화 할 때 기존에 작업들을 취소해야할거 같아서 removeAll() 추가
    // 이전에 설정된 셀의 이미지를 초기화
    override func prepareForReuse() {
        super.prepareForReuse()
        cancellable.removeAll()
        thumbnailImage.image = nil
    }
}
