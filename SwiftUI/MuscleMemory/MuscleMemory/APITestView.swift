//
//  APITestView.swift
//  MuscleMemory
//
//  Created by MadCow on 2024/4/26.
//

import SwiftUI
import SwiftSoup

enum WordMode {
    case engKor
    case korEng
}

struct APITestView: View {
    @State private var word: String = ""
    @State private var currentMode: Bool = true
    private var currentModeName: String {
        return currentMode ? "영한" : "한영"
    }
    
    let session = URLSession.shared
    var body: some View {
        VStack {
            Toggle(isOn: $currentMode, label: {
                Text(currentModeName)
            })
            TextField("단어 입력", text: $word)
                .padding()
                .clipShape(Capsule())
                .border(.black, width: 2)
            
            Button {
                fetchData(mode: currentMode ? "en/ko" : "ko/en", word: word)
            } label: {
                Text("체크")
                    .frame(maxWidth: .infinity)
            }
            .padding()
            .clipShape(Capsule())
            .border(.black, width: 2)
            .disabled(word.isEmpty)
        }
        .padding()
    }
    
    func fetchData(mode: String, word: String) {
        guard let url = URL(string: "https://glosbe.com/\(mode)/\(word.lowercased())") else { return }
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("error > \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("No Result!!")
                return
            }
            
            guard let data = data else {
                print("No Result Data")
                return
            }
            
            if let html = String(data: data, encoding: .utf8) {
                do {
                    let document = try SwiftSoup.parse(html)
                    let paragraph = try document.select(".align-top.inline.leading-10.text-primary-700").text()
                    if paragraph.count > 0 {
                        print("paragraph > \(paragraph.split(separator: " ")[0])")
                    }
                } catch {
                    print("Error parsing HTML: \(error)")
                }
            }
        }
        task.resume()
    }
}

#Preview {
    APITestView()
}
