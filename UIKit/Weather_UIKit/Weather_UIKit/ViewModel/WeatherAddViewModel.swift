//
//  WeatherAddViewModel.swift
//  Weather_UIKit
//
//  Created by MadCow on 2024/5/29.
//

import Foundation
import Combine

class WeatherAddViewModel {
    
    private var cancellable: Cancellable?
    var searchedCity = PassthroughSubject<WeatherModel, Error>()
    
    func getWeatherInfo(city: String) {
        cancellable?.cancel()
        cancellable = WeatherAPI.getWeatherData(city: city)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("error while sink in getWeatherInfo > \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] weather in
                self?.searchedCity.send(weather)
            }
    }
}
