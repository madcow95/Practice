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
    case apiCallError
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
            
            // 이 방식은 ModelContext가 초기화되는 것을 보장하고 나서 loadCities()를 실행하게 합니다. 라는데 이렇게 해도 되려나..?
            DispatchQueue.main.async {
                self.loadCities()
            }
        } catch {
            cities.send(completion: .failure(WeatherModelError.contextNilError))
        }
    }
    
    func addNewCity(newCity: CityModel) {
        guard let context = self.context else { return }
        context.insert(newCity)
        self.loadCities()
    }
    
    func removeCity(targetCity: CityModel) {
        guard let context = self.context else { return }
        context.delete(targetCity)
        self.loadCities()
    }
    
    func loadCities() {
        print("start load cities")
        let descriptor = FetchDescriptor<CityModel>(sortBy: [SortDescriptor<CityModel>(\.date)])
        guard let ctx = self.context else {
            print("context nil error")
            return
        }
        
        do {
            let data = try ctx.fetch(descriptor)
//            TODO: data를 불러와서 여기에서 api한 번에 호출하고 모아서 보내보기
//            let weatherDataPublisher = Publishers.MergeMany(data.map { city in
//                WeatherAPI.getWeatherData(city: city.name)
//                    .mapError { error in
//                        WeatherModelError.apiCallError
//                    }
//                    .eraseToAnyPublisher()
//
//            })
            
            cities.send(data)
        } catch {
            cities.send(completion: .failure(error))
        }
    }
}
