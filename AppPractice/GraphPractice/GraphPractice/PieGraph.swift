//
//  PieGraph.swift
//  GraphPractice
//
//  Created by MadCow on 2025/2/9.
//

import SwiftUI
import Charts

struct PieGraph: View {
    var body: some View {
        let data1: [(weekday: Date, sales: Int)] = (1...10).map {
            (getDate(year: 2024, month: 12, day: $0), (0...100).randomElement()!)
        }
        let data2: [(weekday: Date, sales: Int)] = (1...10).map {
            (getDate(year: 2024, month: 12, day: $0), (0...100).randomElement()!)
        }
        let data3: [(weekday: Date, sales: Int)] = (1...10).map {
            (getDate(year: 2024, month: 12, day: $0), (0...100).randomElement()!)
        }
        let data4: [(weekday: Date, sales: Int)] = (1...10).map {
            (getDate(year: 2024, month: 12, day: $0), (0...100).randomElement()!)
        }
        
        let datas = [
            (city: "Seoul1", data: data1),
            (city: "Seoul2", data: data2),
            (city: "Seoul3", data: data3),
            (city: "Gwangju", data: data4)
        ]
        
        VStack {
            Chart {
                ForEach(datas, id: \.city) { data in
                    ForEach(data.data, id: \.weekday) {
                        SectorMark(angle: .value("City", $0.sales),
                                   innerRadius: .ratio(0.6),
                                   outerRadius: .inset(10))
                            .foregroundStyle(by: .value("City", data.city))
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    PieGraph()
}
