import Foundation
import HealthKit

class HealthKitManager: ObservableObject {
    private let healthStore = HKHealthStore()
    @Published var heartRate: Int = 0
    private var anchor: HKQueryAnchor?

    init() {
        requestAuthorization()
    }
    
    func requestAuthorization() {
        guard let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate) else { return }
        let typesToRead: Set<HKObjectType> = [heartRateType]

        healthStore.requestAuthorization(toShare: nil, read: typesToRead) { success, error in
            if success {
                print("✅ HealthKit 권한 요청 성공")
                self.enableBackgroundDelivery()
                self.startLiveHeartRateUpdates()
            } else {
                print("❌ HealthKit 권한 요청 실패: \(error?.localizedDescription ?? "알 수 없는 오류")")
            }
        }
    }
    
    private func enableBackgroundDelivery() {
        guard let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate) else { return }

        healthStore.enableBackgroundDelivery(for: heartRateType, frequency: .immediate) { success, error in
            if success {
                print("✅ Background Delivery 활성화 성공")
            } else {
                print("❌ Background Delivery 활성화 실패: \(error?.localizedDescription ?? "알 수 없는 오류")")
            }
        }
    }

    private func startLiveHeartRateUpdates() {
        guard let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate) else { return }

        // 1️⃣ 새로운 심박수 데이터가 추가될 때 감지
        let observerQuery = HKObserverQuery(sampleType: heartRateType, predicate: nil) { _, completionHandler, error in
            if let error = error {
                print("❌ Observer Query 오류: \(error.localizedDescription)")
                return
            }

            print("🔄 새로운 심박수 데이터 감지됨!")
            self.fetchLatestHeartRate()
            completionHandler()
        }
        
        healthStore.execute(observerQuery)
        enableBackgroundDelivery()
        
        // 2️⃣ 실시간 업데이트를 위한 Anchored Query 실행
        startAnchoredObjectQuery()
    }

    private func startAnchoredObjectQuery() {
        guard let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate) else { return }

        let anchoredQuery = HKAnchoredObjectQuery(
            type: heartRateType,
            predicate: nil,
            anchor: anchor,
            limit: HKObjectQueryNoLimit
        ) { query, samples, _, newAnchor, error in
            if let error = error {
                print("❌ Anchored Query 오류: \(error.localizedDescription)")
                return
            }

            // 새로운 데이터 감지 시 업데이트
            if let newAnchor = newAnchor {
                self.anchor = newAnchor
            }

            self.processHeartRateSamples(samples)
        }

        // 3️⃣ 실시간 업데이트 활성화 (updateHandler 추가)
        anchoredQuery.updateHandler = { query, samples, _, newAnchor, error in
            if let error = error {
                print("❌ Anchored Query 업데이트 오류: \(error.localizedDescription)")
                return
            }

            if let newAnchor = newAnchor {
                self.anchor = newAnchor
            }

            self.processHeartRateSamples(samples)
        }

        healthStore.execute(anchoredQuery)
    }

    // 📌 심박수 데이터를 가져와서 처리하는 함수
    private func processHeartRateSamples(_ samples: [HKSample]?) {
        guard let samples = samples as? [HKQuantitySample] else { return }

        if let lastSample = samples.last {
            let heartRate = Int(lastSample.quantity.doubleValue(for: HKUnit.count().unitDivided(by: HKUnit.minute())))
            print("💓 실시간 심박수 업데이트: \(heartRate) BPM")

            DispatchQueue.main.async {
                self.heartRate = heartRate
            }
        }
    }

    func fetchLatestHeartRate() {
        guard let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate) else { return }

        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        let query = HKSampleQuery(
            sampleType: heartRateType,
            predicate: nil,
            limit: 1,
            sortDescriptors: [sortDescriptor]
        ) { _, samples, error in
            guard let sample = samples?.first as? HKQuantitySample else {
                print("❌ 최신 심박수 데이터를 가져오지 못함: \(error?.localizedDescription ?? "알 수 없는 오류")")
                return
            }

            let heartRate = Int(sample.quantity.doubleValue(for: HKUnit.count().unitDivided(by: HKUnit.minute())))
            print("💓 최신 심박수: \(heartRate) BPM")

            DispatchQueue.main.async {
                self.heartRate = heartRate
            }
        }

        healthStore.execute(query)
    }
}
