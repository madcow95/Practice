//
//  SubCategoryView.swift
//  MuscleMemory
//
//  Created by MadCow on 2024/4/24.
//

import SwiftUI

struct SubCategoryView: View {
    @State private var subCategory: String = ""
    
    var body: some View {
        VStack {
            Picker("선택하세요", selection: $subCategory) {
                Text("벤치 프레스").tag("벤치프레스")
                Text("플라이 머신").tag("플라이머신")
                Text("인클라인 벤치프레스").tag("인클라인벤치프레스")
                Text("딥스").tag("딥스")
            }
            .pickerStyle(.segmented)
        }
    }
}

#Preview {
    SubCategoryView()
}
