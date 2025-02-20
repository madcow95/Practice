import SwiftUI
import Charts

struct BarChartView: View {
    @State var tempDatas: [TempData] = []
    
    var body: some View {
        VStack {
            Chart {
                ForEach(tempDatas, id: \.date) { data in
                    BarMark(
                        x: .value("Date", data.dateStr),
                        y: .value("Weight", data.weight)
                    )
                    .foregroundStyle(Color.green)
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
