//
//  ViewController.swift
//  AlamofireTest
//
//  Created by MadCow on 2024/7/23.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    let key = "Movie_API_KEY"
    private lazy var taskButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.widthAnchor.constraint(equalToConstant: self.view.frame.width / 2).isActive = true
        btn.heightAnchor.constraint(equalToConstant: self.view.frame.height / 3).isActive = true
        btn.setTitle("Alamofire 테스트", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .black
        btn.addAction(UIAction { [weak self] _ in
            guard let self = self else { return }
            Task {
                await self.fetchData()
            }
            alamofireFetchData()
        }, for: .touchUpInside)
        
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(taskButton)
        
        NSLayoutConstraint.activate([
            taskButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            taskButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    
    func fetchData() async {
        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie") else { return }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        components.queryItems = [
            URLQueryItem(name: "query", value: "기생충"),
            URLQueryItem(name: "include_adult", value: "true"),
            URLQueryItem(name: "language", value: "ko-KR"),
            URLQueryItem(name: "page", value: "1")
        ]
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer \(key)"
        ]
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            print(String(decoding: data, as: UTF8.self))
        } catch {
            print("error \(error.localizedDescription)")
        }
    }
    
    func alamofireFetchData() {
        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie") else { return }
        let parameters: [String: Any] = [
            "query": "기생충",
            "include_adult": "true",
            "language": "ko-KR",
            "page": 1
        ]
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer \(key)"
        ]
        AF.request(url, parameters: parameters, headers: headers).response { response in
            guard let data = response.data else { return }
            print(String(decoding: data, as: UTF8.self))
        }
    }
}
