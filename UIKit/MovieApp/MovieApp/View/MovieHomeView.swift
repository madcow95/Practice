//
//  MovieHomeView.swift
//  MovieApp
//
//  Created by MadCow on 2024/6/14.
//

import UIKit
import Combine

class MovieHomeView: UIViewController {
    
    private let homeViewModel = MovieHomeViewModel()
    private var cancellable = Set<AnyCancellable>()
    
    // UI Components
    private let searchController = UISearchController()
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
        
        setSubscriber()
        configureUI()
    }
    
    func setSubscriber() {
        homeViewModel.$fetchMovieComplete
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.movieTableView.reloadData()
            }
            .store(in: &cancellable)
        
        homeViewModel.$errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errMsg in
                guard let self = self else { return }
                guard let errMsg = errMsg else { return }
                self.showAlert(msg: errMsg)
            }
            .store(in: &cancellable)
    }
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        
        setSearchBar()
        setTableView()
        // MARK: TODO - 최근 개봉 영화, 인기 많은 영화 Horizontal ScrollView로 만들어보기 넷플릭스 처럼
    }
    
    func setSearchBar() {
//        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.sizeToFit()
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func setTableView() {
        view.addSubview(movieTableView)
        
        NSLayoutConstraint.activate([
            movieTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func showAlert(msg: String) {
        let alertController = UIAlertController(title: "오류!", message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

extension MovieHomeView: UISearchBarDelegate {
    // MARK: TODO - 키보드에서 입력할 때마다 debounce로 api호출로 수정
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text, searchText.count > 0 {
            Task {
                await homeViewModel.searchMovieBy(title: searchText)
            }
        } else {
            // Text Field에 입력된 값이 없으면 Table List 초기화
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
    
    // MARK: TODO - 검색결과가 많을경우 무한 스크롤
}
