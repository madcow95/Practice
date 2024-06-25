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
        image.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        
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
        
        if let poster = movie.poster {
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
            
            // MARK: 질문해야할 부분 - MovieHomeView에서 파라미터로 받아오면 거기에서 생성된 viewModel만 바라봐서 그런지 모든 cell에서 같은 이미지만 보임
            // cell이 실행될 때 마다 ViewModel을 생성하는게 좀.. cell에서 Combine변수로 가져와도 괜찮은지
            let viewModel = MovieHomeViewModel()
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
                .sink { [weak self] image in
                    guard let self = self else { return }
                    self.thumbnailImage.image = image
                }
                .store(in: &cancellable)
            
            viewModel.getThumbnailImage(posterUrl: poster)
        } else {
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
    
    // 셀이 재사용되기 전에 호출되어 셀의 상태를 초기화하는 역할
    // 초기화 할 때 기존에 작업들을 취소해야할거 같아서 removeAll() 추가
    // 이전에 설정된 셀의 이미지를 초기화
    override func prepareForReuse() {
        super.prepareForReuse()
        cancellable.removeAll()
        thumbnailImage.image = nil
    }
}
