//
//  View+Extension.swift
//  DELIGHT_LABS_Subject
//
//  Created by MadCow on 2025/2/13.
//

import SwiftUI

// MARK: 여러 파라미터를 받아 가독성 있게 사용할 수 있도록 만든 Text
struct CustomText: View {
    var text: String = ""
    var fontSize: CGFloat = 18
    var fontWeight: Font.Weight = .regular
    var font: Font? = nil
    var fontColor: Color = .black
    var allowsTightening: Bool = false
    
    var body: some View {
        Text(text)
            .font(font == nil ? .system(size: fontSize, weight: fontWeight) : font!)
            .foregroundStyle(fontColor)
            .minimumScaleFactor(allowsTightening ? 0.5 : 0)
            .lineLimit(allowsTightening ? 1 : 0)
            .allowsTightening(allowsTightening)
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
