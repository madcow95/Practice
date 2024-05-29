//
//  AddCityProtocol.swift
//  Weather_UIKit
//
//  Created by MadCow on 2024/5/29.
//

import Foundation
import Combine

protocol AddCityDelegate {
    func addNewCity(newCity: WeatherModel)
}
