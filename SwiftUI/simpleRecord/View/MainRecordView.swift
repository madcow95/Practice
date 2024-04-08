import SwiftUI

struct ContentView2: View {
    @State private var selectedDate = Date()
    
    var body: some View {
        VStack {
            MultiDatePicker(selectedDate: $selectedDate)
                .frame(height: 200)
            
            Image(systemName: "flag.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .padding()
        }
    }
}

struct MultiDatePicker: View {
    @Binding var selectedDate: Date
    
    var body: some View {
        
        DatePicker("Select Date", selection: $selectedDate, displayedComponents: [.date])
            .datePickerStyle(WheelDatePickerStyle())
    }
}

#Preview {
    ContentView2()
}
