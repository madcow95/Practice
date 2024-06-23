//
//  MovieHomeView.swift
//  MovieApp
//
//  Created by MadCow on 2024/6/14.
//

import UIKit
import Combine

class MovieHomeView: UIViewController {
    
    private let searchController = UISearchController()
    private let homeViewModel = MovieHomeViewModel()
    
    private lazy var movieTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieTableViewCell")
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureUI()
    }
    
    func configureUI() {
        setSearchBar()
        setTableView()
    }
    
    func setSearchBar() {
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.sizeToFit()
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func setTableView() {
        homeViewModel.movieTableReloadDelegate = self
        view.addSubview(movieTableView)
        
        NSLayoutConstraint.activate([
            movieTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension MovieHomeView: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 0 {
            Task {
                do {
                    try await homeViewModel.searchMovieBy(name: searchText)
                } catch { }
            }
        } else {
            homeViewModel.searchedMovies = []
        }
    }
}

extension MovieHomeView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.searchedMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        
        let movie = homeViewModel.searchedMovies[indexPath.row]
        cell.configureCell(movie: movie)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovie = homeViewModel.searchedMovies[indexPath.row]
        let detailView = MovieDetailView()
        detailView.selectedMovie = selectedMovie
        navigationController?.pushViewController(detailView, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension MovieHomeView: ReloadMovieTableDelegate {
    func reloadTableView() {
        self.movieTableView.reloadData()
    }
}
