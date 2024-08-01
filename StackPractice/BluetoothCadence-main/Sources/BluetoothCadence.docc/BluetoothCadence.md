# ``BluetoothCadence``

Bluetooth 케이던스 센서와 통신하여 자전거의 속도, 케이던스, 거리를 측정하는 프레임워크입니다.

## Overview

BluetoothCadence 프레임워크는 iOS 애플리케이션에서 Bluetooth 케이던스 센서와 쉽게 연동할 수 있도록 설계되었습니다. 이 프레임워크를 사용하면 자전거의 속도, 케이던스, 주행 거리 등의 정보를 실시간으로 수집하고 분석할 수 있습니다.

주요 기능:
- Bluetooth 케이던스 센서 검색 및 연결
- 실시간 속도, 케이던스, 거리 계산
- 배터리 레벨 모니터링
- 오류 처리 및 로깅

## Topics

### Essentials

- ``BluetoothManager``
- ``BluetoothManagerDelegate``

### Configuration

- ``BTConstants``

### Error Handling

- ``BluetoothManagerError``

## Usage

BluetoothCadence 프레임워크를 사용하려면 다음 단계를 따르세요:

1. BluetoothManager 인스턴스를 생성합니다.
2. BluetoothManagerDelegate를 구현하여 데이터 업데이트를 받습니다.
3. startScanning() 메서드를 호출하여 센서 검색을 시작합니다.

예시 코드:

```swift
class ViewController: UIViewController, BluetoothManagerDelegate {
    let bluetoothManager = BluetoothManager(wheelSize: 2096)  // 700x23C 타이어 크기
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bluetoothManager.delegate = self
        bluetoothManager.startScanning()
    }
    
    func bluetoothManager(_ manager: BluetoothManager, didUpdateCadence cadence: Double) {
        print("New cadence: \(cadence)")
    }
    
    func bluetoothManager(_ manager: BluetoothManager, didUpdateSpeed speed: Double) {
        print("New speed: \(speed)")
    }
    
    // 기타 delegate 메서드 구현...
}
```

## Note

이 프레임워크를 사용하기 위해서는 앱의 Info.plist에 NSBluetoothAlwaysUsageDescription 키를 추가하고 적절한 설명을 제공해야 합니다.
