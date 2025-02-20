//
//  HealthKitManager.swift
//  TrainingRecord
//
//  Created by MadCow on 2025/2/21.
//

import Foundation
import HealthKit

class HealthKitManager: ObservableObject {
    private let healthStore = HKHealthStore()
    var timer: Timer?
    @Published var heartRate: Double = 0
    
    init() {
        self.requestAuthorization()
        self.startPeriodicHeartRateCheck()
    }
    
    func requestAuthorization() {
        let allTypes = Set([
            HKObjectType.workoutType(),
            HKObjectType.quantityType(forIdentifier: .heartRate)!,
            HKObjectType.quantityType(forIdentifier: .stepCount)!
        ])
        
        healthStore.requestAuthorization(toShare: nil, read: allTypes) { success, error in
            if success {
                print("HealthKit 권한 승인됨")
                self.startHeartRateQuery()
            } else if let error = error {
                print("HealthKit 권한 요청 실패: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchAppleWatchDeviceInfo(completion: @escaping (String) -> Void) {
        let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        
        let query = HKSampleQuery(sampleType: heartRateType,
                                  predicate: nil,
                                  limit: 1,
                                  sortDescriptors: [sortDescriptor]) { _, results, error in
            guard let sample = results?.first as? HKQuantitySample else {
                print("애플워치 데이터를 찾을 수 없음: \(error?.localizedDescription ?? "알 수 없음")")
                return
            }
            
            if let deviceInfo = sample.device {
                if let deviceName = deviceInfo.name {
                    DispatchQueue.main.async {
                        completion(deviceName)
                    }
                }
            }
        }
        
        healthStore.execute(query)
    }
    
    func startHeartRateQuery() {
        guard let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate) else { return }
        
        let query = HKAnchoredObjectQuery(
            type: heartRateType,
            predicate: nil,
            anchor: nil,
            limit: HKObjectQueryNoLimit
        ) { query, samples, _, _, error in
            if let samples = samples as? [HKQuantitySample] {
                self.processHeartRateSamples(samples)
            }
        }
        
        query.updateHandler = { query, samples, _, _, error in
            if let samples = samples as? [HKQuantitySample] {
                self.processHeartRateSamples(samples)
            }
        }
        
        healthStore.execute(query)
    }
        
    private func processHeartRateSamples(_ samples: [HKQuantitySample]) {
        guard let lastSample = samples.last else { return }
        let bpm = lastSample.quantity.doubleValue(for: HKUnit.count().unitDivided(by: HKUnit.minute()))
        
        DispatchQueue.main.async {
            self.heartRate = bpm
        }
        
        print("실시간 심박수: \(bpm) BPM")
    }
    
    func startPeriodicHeartRateCheck() {
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
            self.fetchLatestHeartRate()
        }
    }
    
    func fetchLatestHeartRate() {
        guard let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate) else { return }

        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        let query = HKSampleQuery(
            sampleType: heartRateType,
            predicate: nil,
            limit: 1,
            sortDescriptors: [sortDescriptor]
        ) { _, results, error in
            if let sample = results?.first as? HKQuantitySample {
                let bpm = sample.quantity.doubleValue(for: HKUnit.count().unitDivided(by: HKUnit.minute()))
                DispatchQueue.main.async {
                    self.heartRate = bpm
                }
                print("주기적 심박수 확인: \(bpm) BPM")
            }
        }

        healthStore.execute(query)
    }
}
