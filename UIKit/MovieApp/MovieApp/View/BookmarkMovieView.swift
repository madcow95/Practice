//
//  FavoriteViewController.swift
//  MovieApp
//
//  Created by MadCow on 2024/6/14.
//

import UIKit
import SwiftData

class BookmarkMovieView: UIViewController {
    
    private let bookmarkViewModel = BookmarkMovieViewModel()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.register(BookmarkTableViewCell.self, forCellReuseIdentifier: "BookmarkTableViewCell")
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookmarkViewModel.tableReloadDelegate = self
        
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension BookmarkMovieView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarkViewModel.storeManager.storageMovieInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookmarkTableViewCell", for: indexPath) as? BookmarkTableViewCell else {
            return UITableViewCell()
        }
        
        let movie = bookmarkViewModel.storeManager.storageMovieInfo[indexPath.row]
        cell.bookmarkButton.addAction(UIAction{ [weak self] _ in
            guard let self = self else { return }
            movie.bookmarked.toggle()
            cell.bookmarkButton.setImage(UIImage(systemName: movie.bookmarked == true ? "bookmark.fill" : "bookmark"), for: .normal)
            self.bookmarkViewModel.deleteMovie(movie: movie)
        }, for: .touchUpInside)
        cell.configureCell(movie: movie)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension BookmarkMovieView: ReloadBookmarkTableDelegate {
    func reloadBookmarkTable() {
        self.tableView.reloadData()
    }
}
