//
//  SeparateFile.swift
//  Todo
//
//  Created by MadCow on 2024/4/17.
//

import SwiftUI

struct SeparateFile: View {
    @EnvironmentObject var passedData: ShareString
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                TextField("Type here", text: $passedData.message)
                Spacer()
            }
            Spacer()
        }
    }
}

#Preview {
    SeparateFile()
}
