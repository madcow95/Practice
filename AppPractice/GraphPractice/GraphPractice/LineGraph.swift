//
//  ContentView.swift
//  GraphPractice
//
//  Created by MadCow on 2025/2/9.
//

import SwiftUI
import Charts

struct LineGraph: View {
    
    var body: some View {
        let data1: [(weekday: Date, sales: Int)] = (1...10).map {
            (getDate(year: 2024, month: 12, day: $0), (1000...50000).randomElement()!)
        }
        let data2: [(weekday: Date, sales: Int)] = (1...10).map {
            (getDate(year: 2024, month: 12, day: $0), (1000...50000).randomElement()!)
        }
        
        let datas = [
            (city: "Seoul", data: data1),
            (city: "Gwangju", data: data2)
        ]
        VStack {
            Spacer()
            Chart {
                ForEach(datas, id: \.city) { data in
                    ForEach(data.data, id: \.weekday) {
                        LineMark(x: .value("Weekday", $0.weekday),
                                 y: .value("Sales", $0.sales))
//                        BarMark(x: .value("Weekday", $0.weekday),
//                                y: .value("Sales", $0.sales))
                    }
                    .foregroundStyle(by: .value("City", data.city))
                    .symbol(by: .value("City", data.city))
                    .interpolationMethod(.catmullRom)
                }
            }
            .padding()
            Spacer()
        }
        .padding()
    }
    
}

func getDate(year: Int, month: Int, day: Int) -> Date {
    let calendar = Calendar.current
    var components = DateComponents()
    components.year = year
    components.month = month
    components.day = day
    
    return calendar.date(from: components)!
}

#Preview {
    LineGraph()
}
