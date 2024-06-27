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
    
    var cancellable = Set<AnyCancellable>()
    
    var webView: WKWebView!
    
    private let trailerViewModel = MovieTrailerViewModel()
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
        trailerViewModel.$videos
            .sink { [weak self] video in
                guard let self = self else { return }
                guard let videoInfo = video.first else { return }
                let url = videoInfo.id.videoID
                
                let videoURL = URL(string: "https://www.youtube.com/watch?v=\(url)")!
                let request = URLRequest(url: videoURL)
                self.webView.load(request)
            }
            .store(in: &cancellable)
        
        trailerViewModel.fetchVideo(title: movieTitle)
    }
}
