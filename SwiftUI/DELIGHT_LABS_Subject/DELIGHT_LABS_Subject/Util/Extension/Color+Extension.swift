import SwiftUI

// MARK: rgb값에 따른 Color 색상을 사용하기 위한 extension
extension Color {
    static var primaryColor: Color {
        get {
            var rgbValue: UInt64 = 0
            Scanner(string: "363062").scanHexInt64(&rgbValue)
            
            let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
            let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
            let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
            
            return Color(uiColor: UIColor(red: red, green: green, blue: blue, alpha: 1.0))
        }
    }
    
    static var expenseColor: Color {
        get {
            var rgbValue: UInt64 = 0
            Scanner(string: "5BDAA4").scanHexInt64(&rgbValue)
            
            let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
            let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
            let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
            
            return Color(uiColor: UIColor(red: red, green: green, blue: blue, alpha: 1.0))
        }
    }
}
