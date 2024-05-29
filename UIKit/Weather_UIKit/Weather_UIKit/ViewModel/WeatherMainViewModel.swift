//
//  WeatherMainViewModel.swift
//  Weather_UIKit
//
//  Created by MadCow on 2024/5/29.
//

import Foundation

class WeatherMainViewModel {
    
    private var cityList: [WeatherModel] = []
        
    func getCityList() -> [WeatherModel] {
        let copiedCityList = self.cityList
        return copiedCityList
    }
    
    func addNewCity(newCity: WeatherModel) {
        print(newCity)
    }
}
