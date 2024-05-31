//
//  WeatherAddView.swift
//  Weather_UIKit
//
//  Created by MadCow on 2024/5/29.
//

import UIKit
import Combine

class WeatherAddView: UIViewController {
    private let searchController = UISearchController()
    private let weatherAddViewModel = WeatherAddViewModel()
    private var searchedCityWheather: WeatherModel?
    private var cancellable: Cancellable?
    var weatherDelegate: AddCityDelegate?
    
    private lazy var countryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        return label
    }()
    
    private lazy var weatherImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        return label
    }()
    
    private lazy var currentTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        return label
    }()
    
    private lazy var uvLabel: UILabel = {
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
        setSubscriber()
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
    
    func setSubscriber() {
        cancellable?.cancel()
        cancellable = weatherAddViewModel.searchedCity
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("error while search city > \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] weather in
                self?.searchedCityWheather = weather
                DispatchQueue.main.async {
                    self?.setComponents(weather: weather)
                }
            }
    }
    
    func setComponents(weather: WeatherModel) {
        let location = weather.location
        let current = weather.current
        let todayCast = weather.forecast.forecastday.first!
        let sunsetStr = todayCast.astro.sunset.components(separatedBy: " ")[0].components(separatedBy: ":")[0]
        let sunsetHour = Int(sunsetStr)! + 12
        let currentTime = location.localtime.components(separatedBy: " ")[1].components(separatedBy: ":")[0]
        let currentTimeHour = Int(currentTime)!
        
        var imageString: String = ""
        var weatherBackgroundColor: UIColor = .systemBackground
        switch current.cloud {
        case 0..<25:
            imageString = currentTimeHour >= sunsetHour ? "moon.stars" : "sun.max"
            weatherImage.tintColor = .yellow
            weatherBackgroundColor = .orange
        case 25..<50:
            imageString = currentTimeHour >= sunsetHour ? "moon" : "cloud.sun"
            weatherBackgroundColor = UIColor(red: 135/255.0, green: 206/255.0, blue: 235/255.0, alpha: 1.0)
        case 50..<75:
            imageString = "cloud"
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
        countryLabel.text = "Country: \(location.country)"
        nameLabel.text = "City: \(location.name)"
        weatherImage.image = UIImage(systemName: imageString)
        temperatureLabel.text = "Temperature: \(current.tempC)'C"
        currentTimeLabel.text = "Time: \(location.localtime)"
        uvLabel.text = "UV: \(current.uv)"
        
        [countryLabel, nameLabel, weatherImage, temperatureLabel, uvLabel, currentTimeLabel].forEach{ view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            countryLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            countryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            countryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            nameLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 15),
            nameLabel.leadingAnchor.constraint(equalTo: countryLabel.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: countryLabel.trailingAnchor),
            
            weatherImage.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15),
            weatherImage.leadingAnchor.constraint(equalTo: countryLabel.leadingAnchor),
            weatherImage.widthAnchor.constraint(equalToConstant: 50),
            weatherImage.heightAnchor.constraint(equalToConstant: 50),
            
            temperatureLabel.topAnchor.constraint(equalTo: weatherImage.bottomAnchor, constant: 15),
            temperatureLabel.leadingAnchor.constraint(equalTo: countryLabel.leadingAnchor),
            temperatureLabel.trailingAnchor.constraint(equalTo: countryLabel.trailingAnchor),
            
            currentTimeLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 15),
            currentTimeLabel.leadingAnchor.constraint(equalTo: countryLabel.leadingAnchor),
            currentTimeLabel.trailingAnchor.constraint(equalTo: countryLabel.trailingAnchor),
            
            uvLabel.topAnchor.constraint(equalTo: currentTimeLabel.bottomAnchor, constant: 15),
            uvLabel.leadingAnchor.constraint(equalTo: countryLabel.leadingAnchor),
            uvLabel.trailingAnchor.constraint(equalTo: countryLabel.trailingAnchor)
        ])
    }
    
    @objc func addNewCity() {
        guard let weather = searchedCityWheather else { return }
        let newCity = CityModel(name: weather.location.name, date: Date())
        weatherDelegate?.addNewCity(newCity: newCity)
        navigationController?.popViewController(animated: true)
    }
}

extension WeatherAddView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            weatherAddViewModel.getWeatherInfo(city: searchText)
            searchBar.resignFirstResponder()
        }
    }
}

