//
//  TrailerView.swift
//  MovieApp
//
//  Created by MadCow on 2024/6/26.
//

import UIKit
import Combine
import WebKit

class MovieTrailerView: UIViewController, WKNavigationDelegate {
    
    private var cancellable = Set<AnyCancellable>()
    private let trailerViewModel = MovieTrailerViewModel()
    private var webView: WKWebView!
    var movieTitle: String?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        webView = WKWebView(frame: view.bounds)
        view.addSubview(webView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setSubscriber()
    }
    
    func setSubscriber() {
        trailerViewModel.$trailerVideo
            .sink { [weak self] video in
                guard let self = self else { return }
                guard let videoInfo = trailerViewModel.trailerVideo else { return }
                let url = videoInfo.videoID
                
                let videoURL = URL(string: "https://www.youtube.com/watch?v=\(url)")!
                let request = URLRequest(url: videoURL)
                self.webView.load(request)
            }
            .store(in: &cancellable)
        
        trailerViewModel.fetchVideo(title: movieTitle)
    }
}
