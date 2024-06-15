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
    private var cancelleable = Set<AnyCancellable>()
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        
        return scroll
    }()
    
    private let contentView: UIView = {
        let uv = UIView()
        uv.translatesAutoresizingMaskIntoConstraints = false
        
        return uv
    }()
    
    private let recentOpenLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        
        return label
    }()
    
    // TODO: 좌우로 스크롤 가능한 UISCrollView + UIStackView
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setSubscriber()
        setSearchBar()
        configureUI()
    }
    
    func setSubscriber() {
        homeViewModel.$searchedMovies.sink { [weak self] movies in
            
        }.store(in: &cancelleable)
    }
    
    func setSearchBar() {
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.sizeToFit()
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func configureUI() {
        setScrollView()
        setRecentlyOpenMovieUI()
    }
    
    func setScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    func setRecentlyOpenMovieUI() {
        contentView.addSubview(recentOpenLabel)
        
        NSLayoutConstraint.activate([
            recentOpenLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            recentOpenLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
        ])
    }
}

extension MovieHomeView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            Task {
                do {
                    try await homeViewModel.searchMovieBy(name: searchText)
                } catch {
                    print(error)
                }
            }
        }
    }
}
