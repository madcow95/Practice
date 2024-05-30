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
                var imageString: String = ""
                var weatherBackgroundColor: UIColor = .white
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    
                    switch current.cloud {
                    case 0..<25:
                        imageString = "sun.max"
                        self.weatherImage.tintColor = .yellow
                        weatherBackgroundColor = .orange
                    case 25..<50:
                        imageString = "cloud.sun"
                        self.weatherImage.tintColor = .yellow
                        weatherBackgroundColor = UIColor(red: 135/255.0, green: 206/255.0, blue: 235/255.0, alpha: 1.0)
                    case 50..<75:
                        imageString = "cloud.fill"
                        self.weatherImage.tintColor = .white
                        weatherBackgroundColor = .lightGray
                    case 75...100:
                        imageString = "cloud.fill"
                        self.weatherImage.tintColor = .lightGray
                        weatherBackgroundColor = .darkGray
                    default:
                        imageString = ""
                    }
                    
                    self.contentView.backgroundColor = weatherBackgroundColor
                    self.weatherImage.image = UIImage(systemName: imageString)
                    self.temperatureLabel.text = "\(current.tempC)'C"
                    
                    [self.weatherImage, self.temperatureLabel].forEach{ self.contentView.addSubview($0) }
                    
                    NSLayoutConstraint.activate([
                        self.weatherImage.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
                        self.weatherImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
                        
                        self.temperatureLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
                        self.temperatureLabel.leadingAnchor.constraint(equalTo: self.cityLabel.trailingAnchor, constant: 15)
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
