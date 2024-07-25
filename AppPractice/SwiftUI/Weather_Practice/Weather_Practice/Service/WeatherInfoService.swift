//
//  WeatherService.swift
//  Weather_Practice
//
//  Created by MadCow on 2024/6/25.
//

import Foundation
import WeatherKit
import CoreLocation

class WeatherInfoService {
    let weatherService = WeatherService.shared
    
    func getCurrentWeather(for location: CLLocation) async throws -> Weather {
        return try await weatherService.weather(for: location)
    }
}
