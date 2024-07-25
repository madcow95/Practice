//
//  Weather.swift
//  Weather_Practice
//
//  Created by MadCow on 2024/6/25.
//

import Foundation

struct CurrentWeather: Codable {
    let cityName: String
    let temperature: Double
    let description: String
    let humid: Double
    let windSpeed: Double
    let symbolName: String
}
