//
//  WeatherAddView.swift
//  Weather_UIKit
//
//  Created by MadCow on 2024/5/29.
//

import UIKit

class WeatherAddView: UIViewController {
    private let searchController = UISearchController()
    private let weatherAddViewModel = WeatherAddViewModel()
    private var searchedCityWheather: WeatherModel?
    var weatherDelegate: AddCityDelegate?
    
    private let countryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        return label
    }()
    
    private let weatherImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        return label
    }()
    
    private let uvLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureSearchBar()
        setNavigationUI()
    }
    
    func configureSearchBar() {
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.sizeToFit()
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func setNavigationUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addNewCity))
    }
    
    func getWeatherInfo(city: String) {
        weatherAddViewModel.getWeatherInfo(city: city) { [weak self] weather in
            self?.searchedCityWheather = weather
            DispatchQueue.main.async {
                self?.setComponents(weather: weather)
            }
        }
    }
    
    func setComponents(weather: WeatherModel) {
        let location = weather.location
        let current = weather.current
        
        countryLabel.text = location.country
        nameLabel.text = location.name
        temperatureLabel.text = "\(current.tempC)'C"
        uvLabel.text = "\(current.uv)"
        
        var imageString: String = ""
        var weatherBackgroundColor: UIColor = .systemBackground
        switch current.cloud {
        case 0..<25:
            imageString = "sun.max"
            weatherImage.tintColor = .yellow
            weatherBackgroundColor = .systemBlue
        case 25..<50:
            imageString = "cloud.sun"
            weatherBackgroundColor = UIColor(red: 135/255.0, green: 206/255.0, blue: 235/255.0, alpha: 1.0)
        case 50..<75:
            imageString = "cloud.fill"
            weatherImage.tintColor = .white
            weatherBackgroundColor = .lightGray
        case 75..<100:
            imageString = "cloud.fill"
            weatherImage.tintColor = .lightGray
            weatherBackgroundColor = .darkGray
        default:
            imageString = ""
        }
        view.backgroundColor = weatherBackgroundColor
        weatherImage.image = UIImage(systemName: imageString)
        
        [countryLabel, nameLabel, weatherImage, temperatureLabel, uvLabel].forEach{ view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            countryLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            countryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            countryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            nameLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 15),
            nameLabel.leadingAnchor.constraint(equalTo: countryLabel.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: countryLabel.trailingAnchor),
            
            weatherImage.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15),
            weatherImage.leadingAnchor.constraint(equalTo: countryLabel.leadingAnchor),
            weatherImage.trailingAnchor.constraint(equalTo: countryLabel.trailingAnchor),
            
            temperatureLabel.topAnchor.constraint(equalTo: weatherImage.bottomAnchor, constant: 15),
            temperatureLabel.leadingAnchor.constraint(equalTo: countryLabel.leadingAnchor),
            temperatureLabel.trailingAnchor.constraint(equalTo: countryLabel.trailingAnchor),
            
            uvLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 15),
            uvLabel.leadingAnchor.constraint(equalTo: countryLabel.leadingAnchor),
            uvLabel.trailingAnchor.constraint(equalTo: countryLabel.trailingAnchor)
        ])
    }
    
    @objc func addNewCity() {
        guard let weather = searchedCityWheather else { return }
        weatherDelegate?.addNewCity(newCity: weather)
    }
}

extension WeatherAddView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            getWeatherInfo(city: searchText)
            searchBar.resignFirstResponder()
        }
    }
}

