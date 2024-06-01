//
//  WeatherDetailViewModel.swift
//  Weather_UIKit
//
//  Created by MadCow on 2024/6/1.
//

import Foundation
import Combine

class WeatherDetailViewModel {
    let searchedWeather = PassthroughSubject<WeatherModel, Error>()
    private var cancellable = Set<AnyCancellable>()
    
    func getWeatherInfo(city: String) {
        WeatherAPI.getWeatherData(city: city)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("error in WeatherDetailViewModel getWeatherInfo > \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] weather in
                self?.searchedWeather.send(weather)
            }
            .store(in: &cancellable)
    }
}
