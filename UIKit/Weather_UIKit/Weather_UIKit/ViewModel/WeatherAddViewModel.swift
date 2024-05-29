//
//  WeatherAddViewModel.swift
//  Weather_UIKit
//
//  Created by MadCow on 2024/5/29.
//

import Foundation
import Combine
import SwiftData

class WeatherAddViewModel {
    
    private var cancellable = Set<AnyCancellable>()
    
    private func fetchWeatherInfo(city: String) -> AnyPublisher<WeatherModel, Error> {
        let url: URL = URL(string: "https://api.weatherapi.com/v1/forecast.json?key=c50344c8ff6d4861bc405526242905&q=\(city)&days=1&aqi=no&alerts=no&lang=ko")!
        let urlRequest: URLRequest = URLRequest(url: url)
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map{ $0.data }
            .decode(type: WeatherModel.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func getWeatherInfo(city: String, completion: @escaping (_: WeatherModel) -> Void) {
        self.fetchWeatherInfo(city: city)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("error while sink > \(error.localizedDescription)")
                }
            } receiveValue: { weather in
                completion(weather)
            }
            .store(in: &cancellable)
    }
}
