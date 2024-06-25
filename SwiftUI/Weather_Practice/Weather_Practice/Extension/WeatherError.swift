//
//  WeatherError.swift
//  Weather_Practice
//
//  Created by MadCow on 2024/6/25.
//

import Foundation

enum WeatherError: Error {
    case unauthrized // 인증 문제
    case noData // 요청한 위치나 시간에 데이터 없음
    case invalidRequest // 잘못된 요청(좌표 등)
}
