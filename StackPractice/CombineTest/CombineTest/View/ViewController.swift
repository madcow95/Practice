//
//  ViewController.swift
//  CombineTest
//
//  Created by MadCow on 2024/5/8.
//

import UIKit
import Combine

// DispatchQueue.main
// RunLoop.main
// eraseToAnyPublisher

class ViewController: UIViewController {
    
    @Published private var videoInfos: [VideoInfoModel] = []
    
    private let searchField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Search Text"
        tf.text = "침착맨"
        
        return tf
    }()
    
    private let nextPageButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.borderWidth = 1
        btn.setTitle("NextPage", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.tintColor = .white
        
        return btn
    }()
    
    private let searchButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .blue
        btn.setTitle("검색", for: .normal)
        btn.tintColor = .white
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 10
        
        return btn
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()
    
    private var cancellables = Set<AnyCancellable>()
    private var page: Int = 1
    private var isLoading: Bool = false
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(searchField)
        view.addSubview(searchButton)
        view.addSubview(nextPageButton)
        view.addSubview(tableView)
        
        searchButton.addTarget(self, action: #selector(searchVideo), for: .touchUpInside)
        nextPageButton.addTarget(self, action: #selector(toAnotherView), for: .touchUpInside)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ViewCell.self, forCellReuseIdentifier: "ViewCell")
        
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            searchButton.centerYAnchor.constraint(equalTo: searchField.centerYAnchor),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            searchButton.widthAnchor.constraint(equalToConstant: 100),
            searchButton.heightAnchor.constraint(equalTo: searchButton.heightAnchor),
            
            nextPageButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            nextPageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: 5),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: nextPageButton.topAnchor)
        ])
    }
    
    @objc func searchVideo() {
        guard let searchText = self.searchField.text else { return }
        self.videoInfos = []
        self.page = 1
        startLoadVideos(searchText: searchText)
    }
    
    @objc func toAnotherView() {
        let viewController = AnotherView()
        present(viewController, animated: true, completion: nil)
    }
    
    var cancellable: AnyCancellable?
    func startLoadVideos(searchText: String) {
        cancellable?.cancel()
        cancellable = loadVideos(searchText: searchText).sink { completion in
            switch completion {
            case .finished:
                self.page += 1
//                self.cancellables.forEach{ $0.cancel() }
//                self.cancellables.removeAll()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                print("End!")
            case .failure(let error):
//                self.cancellables.forEach{ $0.cancel() }
//                self.cancellables.removeAll()
                print("error! > \(error.localizedDescription)")
            }
        } receiveValue: { [weak self] receivedVideoInfo in
            self?.videoInfos += receivedVideoInfo
        }
    }
    
    func loadVideos(searchText: String) -> AnyPublisher<[VideoInfoModel], Error> {
        let endpoint = "https://dapi.kakao.com/v2/search/vclip?query=\(searchText)&&page=\(self.page)&&size=30"
        let apiKey = "2d848d4c36ef7c694cbee2d4a65f26ca"
        
        var request = URLRequest(url: URL(string: endpoint)!)
        request.httpMethod = "GET"
        request.setValue("KakaoAK \(apiKey)", forHTTPHeaderField: "Authorization")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map{ $0.data }
            .decode(type: VideoDocument.self, decoder: JSONDecoder())
            .map{ $0.documents }
            .eraseToAnyPublisher()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.videoInfos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ViewCell", for: indexPath) as? ViewCell else { return UITableViewCell()
        }
        
        let info = videoInfos[indexPath.item]
        if let imageUrl = URL(string: info.thumbnail) {
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: imageUrl) {
                    if let image = UIImage(data: imageData) {
                        DispatchQueue.main.async {
                            cell.thumbnailImageView.image = image
                        }
                    }
                }
            }
        }
        cell.titleTextField.text = info.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = URL(string: videoInfos[indexPath.item].url) {
            UIApplication.shared.open(url)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            guard let searchText = self.searchField.text else { return }
            startLoadVideos(searchText: searchText)
        }
    }
}
