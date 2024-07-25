//
//  APITestViewModel.swift
//  APITest
//
//  Created by MadCow on 2024/4/16.
//

import Foundation

class APITestViewModel {
    func test() {
        let apiUrl: String = "http://apis.data.go.kr/B551177/StatusOfArrivals/getArrivalsCongestion"
        
        let session = URLSession.shared
        
        if let url = URL(string: apiUrl) {
            print(url)
            let task = session.dataTask(with: url) { data, response, error in
                print(data)
                print(response)
                print(error)
//                if let error = error {
//                    print("Error: \(error.localizedDescription)")
//                    return
//                }
                
                
            }
        }
    }
}
