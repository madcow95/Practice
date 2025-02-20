//
//  CityModel.swift
//  Weather_UIKit
//
//  Created by MadCow on 2024/5/30.
//

import Foundation
import SwiftData

@Model
class CityModel {
    let id: UUID = UUID()
    let name: String
    let date: Date
    
    init(name: String, date: Date) {
        self.name = name
        self.date = date
    }
}
