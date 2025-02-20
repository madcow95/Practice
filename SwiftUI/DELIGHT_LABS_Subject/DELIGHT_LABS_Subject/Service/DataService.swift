//
//  DataService.swift
//  DELIGHT_LABS_Subject
//
//  Created by MadCow on 2025/2/13.
//

import Foundation
import Combine

class DataService {
    func fetchData() -> AnyPublisher<[Transaction], Error> {
        guard let url = Bundle.main.url(forResource: "delightlabs-hometest-mockdata-241119", withExtension: "json") else {
            return Fail(
                error: NSError(
                    domain: "DataService",
                    code: -1,
                    userInfo: [NSLocalizedDescriptionKey: "JSON 파일을 찾을 수 없음"]
                )
            )
            .eraseToAnyPublisher()
        }

        return Future<[Transaction], Error> { promise in
            do {
                let data = try Data(contentsOf: url)
                let transactions = try JSONDecoder().decode([Transaction].self, from: data)
                
                promise(.success(transactions))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
}
