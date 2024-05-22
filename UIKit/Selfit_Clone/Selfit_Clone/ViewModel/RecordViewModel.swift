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
    func getTestWorkout() -> AnyPublisher<Workout, Error> {
        Future<Workout, Error> { promise in
            db.collection("WorkoutRecords").document("choi").getDocument { (doc, error) in
                if let error = error {
                    promise(.failure(error))
                    print("error > \(error.localizedDescription)")
                } else {
                    guard let document = doc else {
                        print("doc is empty")
                        promise(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "doc is empty"])))
                        return
                    }
                    if document.exists {
                        do {
                            let workout = try document.data(as: Workout.self)
                            promise(.success(workout))
                        } catch {
                            promise(.failure(error))
                            print("error > \(error.localizedDescription)")
                        }
                    } else {
                        promise(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Document does not exist"])))
                        print("document is empty")
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
