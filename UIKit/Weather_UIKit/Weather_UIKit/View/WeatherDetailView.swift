//
//  WeatherDetailView.swift
//  Weather_UIKit
//
//  Created by MadCow on 2024/5/31.
//

import UIKit
import Combine

class WeatherDetailView: UIViewController {
    
    var receivedCity: CityModel?
    private let detailViewModel = WeatherDetailViewModel()
    private var cancellable = Set<AnyCancellable>()
    private var prevLeadingAnchor: NSLayoutXAxisAnchor!
    
    private let cityNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        
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
        setScrollView()
        setSubscriber()
        callWeatherInfo()
    }
    
    func configureWeather() {
        guard let city = receivedCity else { return }
        
        cityNameLabel.text = "도시: \(city.name)"
        
        view.addSubview(cityNameLabel)
        
        NSLayoutConstraint.activate([
            cityNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            cityNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    func setScrollView() {
        view.addSubview(hScrollView)
        hScrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            hScrollView.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 10),
            hScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: hScrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: hScrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: hScrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: hScrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalToConstant: 1300)
        ])
        
        prevLeadingAnchor = contentView.leadingAnchor
    }
    
    func setSubscriber() {
        detailViewModel.searchedWeather
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("error in WeatherDetailView > \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] weather in
                DispatchQueue.main.sync {
                    self?.configureWeather(weather: weather)
                }
            }
            .store(in: &cancellable)
    }
    
    func callWeatherInfo() {
        guard let city = receivedCity else { return }
        detailViewModel.getWeatherInfo(city: city.name)
    }
    
    func configureWeather(weather: WeatherModel) {
        let forecasts = weather.forecast.forecastday
        for (idx, forecast) in forecasts.enumerated() {
            let hStack = UIStackView(frame: CGRect(x: 0, y: 0, width: 180, height: 80))
            hStack.translatesAutoresizingMaskIntoConstraints = false
            hStack.axis = .vertical
            hStack.alignment = .center
            hStack.spacing = 5
            hStack.layer.borderWidth = 1
            hStack.layer.cornerRadius = 10
            
            let dateLabel = UILabel()
            dateLabel.text = forecast.date
            dateLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            
            let minTemperatureLabel = UILabel()
            minTemperatureLabel.text = "최저: \(forecast.day["mintemp_c"]!)°C"
            minTemperatureLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
            
            let maxTemperatureLabel = UILabel()
            maxTemperatureLabel.text = "최고: \(forecast.day["maxtemp_c"]!)°C"
            maxTemperatureLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
            
            let chanceOfRain = UILabel()
            chanceOfRain.text = "비확률: \(forecast.day["daily_chance_of_rain"]!)%"
            chanceOfRain.font = UIFont.systemFont(ofSize: 15, weight: .bold)
            
            hStack.addArrangedSubview(dateLabel)
            hStack.addArrangedSubview(minTemperatureLabel)
            hStack.addArrangedSubview(maxTemperatureLabel)
            hStack.addArrangedSubview(chanceOfRain)
            
            contentView.addSubview(hStack)
            
            NSLayoutConstraint.activate([
                hStack.topAnchor.constraint(equalTo: contentView.centerYAnchor),
                hStack.leadingAnchor.constraint(equalTo: prevLeadingAnchor, constant: idx == 0 ? 8 : 130)
            ])
            prevLeadingAnchor = hStack.leadingAnchor
        }
    }
}
