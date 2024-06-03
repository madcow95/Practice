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
    
    private let hScrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsHorizontalScrollIndicator = true
        scroll.showsVerticalScrollIndicator = false
        
        return scroll
    }()
    
    private let contentView: UIView = {
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
            hScrollView.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 25),
            hScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: hScrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: hScrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: hScrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: hScrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalToConstant: 1500)
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
            let vStack = TouchableStackView(frame: CGRect(x: 0, y: 0, width: 180, height: 80))
            
            let dateLabel = UILabel()
            dateLabel.text = "  \(forecast.date)  "
            dateLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            
            let minTemperatureLabel = UILabel()
            minTemperatureLabel.text = "최저: \(forecast.day["mintemp_c"]!)°C"
            minTemperatureLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
            minTemperatureLabel.textColor = .systemBlue
            
            let maxTemperatureLabel = UILabel()
            maxTemperatureLabel.text = "최고: \(forecast.day["maxtemp_c"]!)°C"
            maxTemperatureLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
            maxTemperatureLabel.textColor = .systemRed
            
            let chanceOfRain = UILabel()
            chanceOfRain.text = "비올확률: \(forecast.day["daily_chance_of_rain"]!)%"
            chanceOfRain.font = UIFont.systemFont(ofSize: 15, weight: .bold)
            
            vStack.addArrangedSubview(dateLabel)
            vStack.addArrangedSubview(minTemperatureLabel)
            vStack.addArrangedSubview(maxTemperatureLabel)
            vStack.addArrangedSubview(chanceOfRain)
            
            contentView.addSubview(vStack)
            
            NSLayoutConstraint.activate([
                vStack.topAnchor.constraint(equalTo: contentView.centerYAnchor),
                vStack.leadingAnchor.constraint(equalTo: prevLeadingAnchor, constant: idx == 0 ? 8 : 150)
            ])
            prevLeadingAnchor = vStack.leadingAnchor
        }
    }
}
