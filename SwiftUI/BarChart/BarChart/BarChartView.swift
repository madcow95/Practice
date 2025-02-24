import SwiftUI
import Charts

struct BarChartView: View {
    @State var tempDatas: [TempData] = []
    @State var selectedDateStr: String = ""
    
    var body: some View {
        VStack {
            Text("선택된 날짜: \(selectedDateStr)")
                .font(.headline)
            Chart {
                ForEach(tempDatas, id: \.date) { data in
                    BarMark(
                        x: .value("Date", data.dateStr),
                        y: .value("Weight", data.weight)
                    )
                    .foregroundStyle(data.dateStr == self.selectedDateStr ? Color.green.opacity(0.5) : Color.green)
                    .annotation(position: .overlay) {
                        VStack(alignment: .center) {
                            Text("\(data.weight, specifier: "%.1f")kg")
                                .font(.caption2)
                                .bold()
                                .foregroundStyle(Color.white)
                        }
                    }
                }
            }
            .chartOverlay { chartProxy in
                Rectangle()
                    .fill(Color.clear)
                    .contentShape(Rectangle())
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let location = value.location
                                if let selectedDateStr: String = chartProxy.value(atX: location.x) {
                                    self.selectedDateStr = selectedDateStr
                                }
                            }
                            .onEnded { _ in
                                self.selectedDateStr = ""
                            }
                    )
            }
        }
        .padding()
        .onAppear {
            let today = Date()
            let calendar = Calendar.current
            tempDatas = (0..<7).compactMap {
                if let date = calendar.date(byAdding: .day, value: -6 + $0, to: today) {
                    return TempData(date: date,
                             weight: Double.random(in: 60...80))
                }
                return nil
            }
        }
    }
}

struct TempData {
    let date: Date
    var dateStr: String {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd"
            
            return dateFormatter.string(from: self.date)
        }
    }
    let weight: Double
}


#Preview {
    BarChartView()
}
