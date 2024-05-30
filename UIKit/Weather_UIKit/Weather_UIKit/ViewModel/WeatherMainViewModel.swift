//
//  WeatherMainViewModel.swift
//  Weather_UIKit
//
//  Created by MadCow on 2024/5/29.
//

import Foundation
import SwiftData
import Combine

enum WeatherModelError: Error {
    case contextNilError
    case containerNilError
}

class WeatherMainViewModel {
    
    var cities = PassthroughSubject<[CityModel], Error>()
    private var container: ModelContainer?
    private var context: ModelContext?
    
    init() {
        do {
            self.container = try ModelContainer(for: CityModel.self)
            guard let container = self.container else {
                // SwiftData에러인데 이렇게 보내는게 맞나..?
                cities.send(completion: .failure(WeatherModelError.containerNilError))
                return
            }
            self.context = ModelContext(container)
        } catch {
            cities.send(completion: .failure(WeatherModelError.contextNilError))
        }
    }
    
    func addNewCity(newCity: CityModel) {
        guard let context = self.context else { return }
        context.insert(newCity)
        self.loadCities()
    }
    
    func loadCities() {
        let descriptor = FetchDescriptor<CityModel>(sortBy: [SortDescriptor<CityModel>(\.date)])
        guard let ctx = self.context else {
            print("context nil error")
            return
        }
        
        do {
            let data = try ctx.fetch(descriptor)
            cities.send(data)
        } catch {
            cities.send(completion: .failure(error))
        }
    }
}
