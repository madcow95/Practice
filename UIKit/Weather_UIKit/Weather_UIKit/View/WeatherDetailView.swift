//
//  WeatherDetailView.swift
//  Weather_UIKit
//
//  Created by MadCow on 2024/5/31.
//

import UIKit

class WeatherDetailView: UIViewController {
    
    var receivedCity: CityModel?
    
    private let cityNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var hScrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsHorizontalScrollIndicator = true
        scroll.showsVerticalScrollIndicator = false
        
        return scroll
    }()
    
    private lazy var contentView: UIView = {
        let content = UIView()
        content.translatesAutoresizingMaskIntoConstraints = false
        
        return content
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureWeather()
    }
    
    func configureWeather() {
        guard let city = receivedCity else { return }
        
        cityNameLabel.text = city.name
        
        view.addSubview(cityNameLabel)
        
        NSLayoutConstraint.activate([
            cityNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityNameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
