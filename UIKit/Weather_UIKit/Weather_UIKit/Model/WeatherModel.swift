//
//  WeatherModel.swift
//  Weather_UIKit
//
//  Created by MadCow on 2024/5/29.
//

import Foundation
import SwiftData

// MARK: - Welcome
@Model
class WeatherModel: Codable {
    let location: Location
    let current: Current
    let forecast: Forecast
    
    enum CodingKeys: String, CodingKey {
        case location, current, forecast
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.location = try container.decode(Location.self, forKey: .location)
        self.current = try container.decode(Current.self, forKey: .current)
        self.forecast = try container.decode(Forecast.self, forKey: .forecast)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(location, forKey: .location)
        try container.encode(current, forKey: .current)
        try container.encode(forecast, forKey: .forecast)
    }
}

// MARK: - Location
struct Location: Codable {
    let name, region, country: String
    let lat, lon: Double
    let localtime: String

    enum CodingKeys: String, CodingKey {
        case name, region, country, lat, lon
        case localtime
    }
}

// MARK: - Current
struct Current: Codable {
    let tempC: Double
    let isDay: Int
    let windKph: Double
    let windDegree: Double
    let windDir: WindDir
    let pressureMB: Double
    let pressureIn: Double
    let humidity, cloud: Int
    let gustKph, visKM, uv, precipMm, precipIn, dewpointC, feelslikeC, windchillC, heatindexC: Double

    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case isDay = "is_day"
        case windKph = "wind_kph"
        case windDegree = "wind_degree"
        case windDir = "wind_dir"
        case pressureMB = "pressure_mb"
        case pressureIn = "pressure_in"
        case precipMm = "precip_mm"
        case precipIn = "precip_in"
        case humidity, cloud
        case feelslikeC = "feelslike_c"
        case windchillC = "windchill_c"
        case heatindexC = "heatindex_c"
        case dewpointC = "dewpoint_c"
        case visKM = "vis_km"
        case uv
        case gustKph = "gust_kph"
    }
}

enum WindDir: String, Codable {
    case n = "N"
    case ne = "NE"
    case nw = "NW"
    case nne = "NNE"
    case nnw = "NNW"
    case s = "S"
    case se = "SE"
    case sse = "SSE"
    case ssw = "SSW"
    case sw = "SW"
    case e = "E"
    case ene = "ENE"
    case ese = "ESE"
    case w = "W"
    case wsw = "WSW"
    case wnw = "WNW"
}

// MARK: - Forecast
struct Forecast: Codable {
    let forecastday: [Forecastday]
}

// MARK: - Forecastday
struct Forecastday: Codable {
    let date: String
    let dateEpoch: Int
    let day: [String: Double]
    let astro: Astro
    let hour: [Hour]

    enum CodingKeys: String, CodingKey {
        case date
        case dateEpoch = "date_epoch"
        case day, astro, hour
    }
}

// MARK: - Astro
struct Astro: Codable {
    let sunrise, sunset, moonrise, moonset, moonPhase: String
    let moonIllumination: Double

    enum CodingKeys: String, CodingKey {
        case sunrise, sunset, moonrise, moonset
        case moonPhase = "moon_phase"
        case moonIllumination = "moon_illumination"
    }
}

// MARK: - Hour
struct Hour: Codable {
    let timeEpoch: Int
    let time: String
    let tempC: Double
    let isDay: Int
    let windKph: Double
    let windDegree: Int
    let windDir: WindDir
    let pressureMB, precipMm, snowCM, humidity: Double
    let cloud: Int
    let feelslikeC, windchillC, heatindexC, dewpointC: Double
    let willItRain, chanceOfRain, willItSnow, chanceOfSnow: Int
    let visKM: Double
    let gustKph: Double
    let uv: Int
    let shortRAD, diffRAD: Double

    enum CodingKeys: String, CodingKey {
        case timeEpoch = "time_epoch"
        case time
        case tempC = "temp_c"
        case isDay = "is_day"
        case windKph = "wind_kph"
        case windDegree = "wind_degree"
        case windDir = "wind_dir"
        case pressureMB = "pressure_mb"
        case precipMm = "precip_mm"
        case snowCM = "snow_cm"
        case humidity, cloud
        case feelslikeC = "feelslike_c"
        case windchillC = "windchill_c"
        case heatindexC = "heatindex_c"
        case dewpointC = "dewpoint_c"
        case willItRain = "will_it_rain"
        case chanceOfRain = "chance_of_rain"
        case willItSnow = "will_it_snow"
        case chanceOfSnow = "chance_of_snow"
        case visKM = "vis_km"
        case gustKph = "gust_kph"
        case uv
        case shortRAD = "short_rad"
        case diffRAD = "diff_rad"
    }
}
