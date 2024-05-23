//
//  HomeViewModel.swift
//  Selfit_Clone
//
//  Created by MadCow on 2024/5/20.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore
import Firebase
import Combine

struct RecordViewModel {
    let db = Firestore.firestore()
    
    // MARK: TODO. 
    func getAllWorkout() -> AnyPublisher<Workout, Error> {
        Future<Workout, Error> { promise in
            db.collection("users").document("choi").getDocument { (doc, error) in
                if let error = error {
                    promise(.failure(error))
                } else {
                    guard let document = doc, document.exists, let data = document.data() else {
                        promise(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "doc is empty"])))
                        return
                    }
                    
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
                        let topLevelData = try JSONDecoder().decode(TopLevelData.self, from: jsonData)
                        let workout = topLevelData.workout
                        promise(.success(workout))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
