//
//  TrailerView.swift
//  MovieApp
//
//  Created by MadCow on 2024/6/26.
//

import UIKit
import AVKit

class MovieTrailerView: UIViewController {
    
    private let trailerViewModel = MovieTrailerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        
        Task {
            await trailerViewModel.configureUI()
        }
    }
}
