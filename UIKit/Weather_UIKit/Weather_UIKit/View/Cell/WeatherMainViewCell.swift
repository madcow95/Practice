//
//  WeatherMainViewCell.swift
//  Weather_UIKit
//
//  Created by MadCow on 2024/5/29.
//

import UIKit
import Combine

class WeatherMainViewCell: UITableViewCell {
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        
        return label
    }()
    
    private lazy var currentTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        
        return label
    }()
    
    private lazy var weatherImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    private var cancellable: Cancellable?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    func configureUI(city: CityModel) {
        cityLabel.text = city.name
        self.contentView.addSubview(cityLabel)
        
        cancellable?.cancel()
        cancellable = WeatherAPI.getWeatherData(city: city.name)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("error in configureUI > \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] weather in
                let current = weather.current
                let todayCast = weather.forecast.forecastday.first!
                let sunsetStr = todayCast.astro.sunset.components(separatedBy: " ")[0].components(separatedBy: ":")[0]
                let sunsetHour = Int(sunsetStr)! + 12
                let currentTime = weather.location.localtime.components(separatedBy: " ")[1].components(separatedBy: ":")[0]
                let currentTimeHour = Int(currentTime)!
                
                var imageString: String = ""
                var weatherBackgroundColor: UIColor = .systemBackground
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    
                    switch current.cloud {
                    case 0..<25:
                        imageString = currentTimeHour >= sunsetHour ? "moon.stars" : "sun.max"
                        self.weatherImage.tintColor = .yellow
                        weatherBackgroundColor = .orange
                    case 25..<50:
                        imageString = currentTimeHour >= sunsetHour ? "moon" : "cloud.sun"
                        self.weatherImage.tintColor = .yellow
                        weatherBackgroundColor = UIColor(red: 135/255.0, green: 206/255.0, blue: 235/255.0, alpha: 1.0)
                    case 50..<75:
                        imageString = "cloud"
                        self.weatherImage.tintColor = .white
                        weatherBackgroundColor = .lightGray
                    default:
                        imageString = "cloud.fill"
                        self.weatherImage.tintColor = .lightGray
                        weatherBackgroundColor = .darkGray
                    }
                    
                    self.contentView.backgroundColor = weatherBackgroundColor
                    self.temperatureLabel.text = "\(current.tempC)'C"
                    self.currentTimeLabel.text = weather.location.localtime
                    self.weatherImage.image = UIImage(systemName: imageString)
                    
                    [self.temperatureLabel, self.currentTimeLabel, self.weatherImage].forEach{ self.contentView.addSubview($0) }
                    
                    NSLayoutConstraint.activate([
                        self.temperatureLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
                        self.temperatureLabel.leadingAnchor.constraint(equalTo: self.cityLabel.trailingAnchor, constant: 15),
                        
                        self.currentTimeLabel.topAnchor.constraint(equalTo: self.cityLabel.bottomAnchor, constant: 8),
                        self.currentTimeLabel.leadingAnchor.constraint(equalTo: self.cityLabel.leadingAnchor),
                        
                        self.weatherImage.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
                        self.weatherImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
                        self.weatherImage.widthAnchor.constraint(equalToConstant: 50),
                        self.weatherImage.heightAnchor.constraint(equalToConstant: 50),
                    ])
                }
            }
        
        NSLayoutConstraint.activate([
            self.cityLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.cityLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
