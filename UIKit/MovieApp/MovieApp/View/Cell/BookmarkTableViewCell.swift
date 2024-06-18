//
//  BookmarkTableViewCell.swift
//  MovieApp
//
//  Created by MadCow on 2024/6/18.
//

import UIKit

class BookmarkTableViewCell: UITableViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var bookmarkButton: UIButton = {
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
    
    func configureCell(movie: MovieInfoStorage) {
        titleLabel.text = movie.title
        
        bookmarkButton.setImage(UIImage(systemName: movie.bookmarked == true ? "bookmark.fill" : "bookmark"), for: .normal)
        bookmarkButton.addAction(UIAction{ [weak self] _ in
            guard let self = self else { return }
            movie.bookmarked.toggle()
            self.bookmarkButton.setImage(UIImage(systemName: movie.bookmarked == true ? "bookmark.fill" : "bookmark"), for: .normal)
        }, for: .touchUpInside)
        
        self.addSubview(titleLabel)
        self.addSubview(bookmarkButton)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            bookmarkButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            bookmarkButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
