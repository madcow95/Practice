//
//  WeatherViewModel.swift
//  Weather_Practice
//
//  Created by MadCow on 2024/6/25.
//

import Foundation
import WeatherKit
import CoreLocation
import Combine

class WeatherViewModel: ObservableObject {
    
    @Published var currentWeatherInfo: CurrentWeather?
    @Published var weatherInfoIsNil: Bool = true
    
    private let service = WeatherInfoService()
    private var currentLongitude: CLLocationDegrees? = nil
    private var currentLatitude: CLLocationDegrees? = nil
    var locationManager: CLLocationManager = CLLocationManager()
    
    init() {
        if locationManager.authorizationStatus == .authorizedAlways ||
            locationManager.authorizationStatus == .authorizedWhenInUse {
            if let location = locationManager.location {
                self.currentLongitude = location.coordinate.longitude
                self.currentLatitude = location.coordinate.latitude
            }
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func fetchWeather() async {
        guard let currentLatitude = self.currentLatitude, 
              let currentLongitude = self.currentLongitude else {
            return
        }
        
        do {
            let weatherInfo = try await service.getCurrentWeather(for: CLLocation(latitude: currentLatitude, longitude: currentLongitude))
            
            let todayWeather = weatherInfo.currentWeather
            currentWeatherInfo = CurrentWeather(cityName: "서울시",
                                                temperature: todayWeather.temperature.value,
                                                description: todayWeather.condition.description,
                                                humid: todayWeather.humidity,
                                                windSpeed: todayWeather.wind.speed.value,
                                                symbolName: todayWeather.symbolName)
        } catch {
            print("error > \(error.localizedDescription)")
        }
    }
}
