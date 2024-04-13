//
//  TodoDetailView.swift
//  Todo
//
//  Created by MadCow on 2024/4/13.
//

import SwiftUI

struct TodoDetailView: View {
    
    @State var str: String
    
    var body: some View {
        VStack {
            Text(str)
        }
    }
}

#Preview {
    TodoDetailView(str: "")
}
