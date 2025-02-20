//
//  WeatherView.swift
//  Weather_Practice
//
//  Created by MadCow on 2024/6/25.
//

import SwiftUI

struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        VStack {
            if let currentWeather = viewModel.currentWeatherInfo {
                ScrollView(.vertical) {
                    VStack {
                        Image(systemName: "\(currentWeather.symbolName)")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .symbolRenderingMode(.multicolor)
                            .padding()
                        Text("온도: \(currentWeather.temperature)°C")
                        Text("설명: \(currentWeather.description)")
                        Text("습도: \(currentWeather.humid)")
                        Text("풍속: \(currentWeather.windSpeed)")
                        Divider()
                    }
                }
            } else {
                ProgressView()
            }
        }
        .task {
             await viewModel.fetchWeather()
        }
        .padding(.top, 200)
    }
}

#Preview {
    WeatherView()
}
