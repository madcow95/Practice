//
//  VideoPlayView.swift
//  CombineTest
//
//  Created by MadCow on 2024/5/8.
//

import UIKit
import Combine

class AnotherView: UIViewController {
    
    private let requestButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .blue
        btn.setTitle("Request", for: .normal)
        btn.tintColor = .white
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 10
        
        return btn
    }()
    
    private let listTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        view.addSubview(requestButton)
        view.addSubview(listTable)
        
        requestButton.addTarget(self, action: #selector(requestAPI), for: .touchUpInside)
        listTable.delegate = self
        listTable.dataSource = self
        listTable.register(ListViewCell.self, forCellReuseIdentifier: "ListViewCell")
        
        NSLayoutConstraint.activate([
            requestButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            requestButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            
            listTable.topAnchor.constraint(equalTo: requestButton.bottomAnchor, constant: 10),
            listTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    var list: [Contents] = []
    var page: Int = 1
    var searchText: String = "FC서울"
    var cancellable = Set<AnyCancellable>()
    
    @objc func requestAPI() {
        apiRequest().sink { result in
            switch result {
            case .finished:
                print("finished!")
            case .failure(let error):
                print("error! > \(error)")
            }
        } receiveValue: { [weak self] response in
            DispatchQueue.main.async {
                self?.list = response
                self?.listTable.reloadData()
            }
        }.store(in: &cancellable)

    }
    
    func apiRequest() -> AnyPublisher<[Contents], Error> {
        let endpoint = "https://dapi.kakao.com/v2/search/web?query=\(searchText)&&page=\(self.page)&&size=30"
        let apiKey = "e2bbe272dc60ca8f0be0dd419334a2e9"
        
        let url: URL = URL(string: endpoint)!
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("KakaoAK \(apiKey)", forHTTPHeaderField: "Authorization")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map{ $0.data }
            .decode(type: Document.self, decoder: JSONDecoder())
            .map{ $0.documents }
            .eraseToAnyPublisher()
    }
}

extension AnotherView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListViewCell", for: indexPath) as? ListViewCell else {
            return UITableViewCell()
        }
        
        cell.title.text = list[indexPath.item].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
