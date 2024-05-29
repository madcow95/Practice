//
//  WeatherMainViewModel.swift
//  Weather_UIKit
//
//  Created by MadCow on 2024/5/29.
//

import Foundation
import SwiftData
import Combine

class WeatherMainViewModel {
    
    var cities = PassthroughSubject<[WeatherModel], Error>()
    var weatherDelegate: AddCityDelegate?
    var container: ModelContainer?
    var context: ModelContext?
    
    init() {
        do {
            self.container = try ModelContainer(for: WeatherModel.self)
            if let container = self.container {
                self.context = ModelContext(container)
            }
        } catch {
            print(error)
        }
    }
    
    func addNewCity(newCity: WeatherModel) {
        guard let context = self.context else { return }
        context.insert(newCity)
        self.loadCities()
    }
    
    func loadCities() {
        let descriptor = FetchDescriptor<WeatherModel>()
        guard let ctx = self.context else {
            print("context nil error")
            return
        }
        
        do {
            let data = try ctx.fetch(descriptor)
            cities.send(data)
        } catch {
            print("load todo fetch error")
        }
    }
}
