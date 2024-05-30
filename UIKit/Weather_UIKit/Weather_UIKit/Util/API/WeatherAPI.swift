//
//  WeatherAPI.swift
//  Weather_UIKit
//
//  Created by MadCow on 2024/5/30.
//

import Foundation
import Combine

//enum WeatherAPI {
//    case getSingleWeather
//    case getMultipleWeather
//    
//    func getWeatherDatas(city: String) {
//        switch self {
//        case .getSingleWeather:
//            WeatherAPIStruct.getSingleWeather(city: city)
//        case .getMultipleWeather:
//            print("multi")
//        }
//    }
//}

struct WeatherAPI {
    private static let firstUrlStr: String = "https://api.weatherapi.com/v1/forecast.json?key=c50344c8ff6d4861bc405526242905&q="
    private static let secondUrlStr: String = "&days=1&aqi=no&alerts=no&lang=ko"
    
    static func getWeatherData(city: String) -> AnyPublisher<WeatherModel, Error> {
        let url: URL = URL(string: "\(firstUrlStr)\(city)\(secondUrlStr)")!
        let urlRequest: URLRequest = URLRequest(url: url)
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map{ $0.data }
            .decode(type: WeatherModel.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
