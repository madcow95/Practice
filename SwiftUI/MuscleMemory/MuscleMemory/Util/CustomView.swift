//
//  CustomView.swift
//  MuscleMemory
//
//  Created by MadCow on 2024/4/25.
//

import SwiftUI

struct CustomText<Content: View>: View {
    @ViewBuilder let content: Content
    
    var body: some View {
        content
            .frame(width: UIWindow().frame.width / 1.2, height: 20)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 1)
                    .background(Color.white)
            )
    }
}
