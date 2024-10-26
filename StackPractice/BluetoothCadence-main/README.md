# BluetoothCadence

![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)
![Platform](https://img.shields.io/badge/platforms-iOS%2013.0+-blue.svg)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)

BluetoothCadence는 iOS 애플리케이션에서 Bluetooth 케이던스 센서와 쉽게 연동할 수 있도록 설계된 Swift 프레임워크입니다. 이 프레임워크를 사용하면 자전거의 속도, 케이던스, 주행 거리 등의 정보를 실시간으로 수집하고 분석할 수 있습니다.

## 주요 기능

- Bluetooth 케이던스 센서 자동 검색 및 연결
- 실시간 속도, 케이던스, 거리 계산
- 배터리 레벨 모니터링
- 오류 처리 및 로깅
- 커스텀 휠 사이즈 지원

## 요구 사항

- iOS 13.0+
- Swift 5.0+
- Xcode 12.0+

## 설치 방법

### Swift Package Manager

1. Xcode에서 File > Swift Packages > Add Package Dependency를 선택합니다.
2. 프로젝트의 GitHub URL을 입력합니다: `https://github.com/code-grove/BluetoothCadence.git`
3. 버전 또는 브랜치를 선택하고 "Next"를 클릭합니다.
4. "Finish"를 클릭하여 설치를 완료합니다.

### 수동 설치

1. 이 저장소를 클론하거나 다운로드합니다.
2. `BluetoothCadence` 폴더를 프로젝트에 드래그 앤 드롭합니다.
3. "Copy items if needed"를 선택하고 "Finish"를 클릭합니다.

## 사용 방법

1. `BluetoothManager` 인스턴스를 생성합니다.
2. `BluetoothManagerDelegate`를 구현하여 데이터 업데이트를 받습니다.
3. `startScanning()` 메서드를 호출하여 센서 검색을 시작합니다.

예시 코드:

```swift
import BluetoothCadence

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

## 주의사항

- 이 프레임워크를 사용하기 위해서는 앱의 Info.plist에 `NSBluetoothAlwaysUsageDescription` 키를 추가하고 적절한 설명을 제공해야 합니다.
- Bluetooth 기능을 사용하려면 실제 기기에서 테스트해야 합니다. 시뮬레이터에서는 작동하지 않습니다.

## 기여 방법

1. 이 저장소를 포크합니다.
2. 새로운 기능 브랜치를 생성합니다 (`git checkout -b feature/AmazingFeature`).
3. 변경 사항을 커밋합니다 (`git commit -m 'Add some AmazingFeature'`).
4. 브랜치에 푸시합니다 (`git push origin feature/AmazingFeature`).
5. Pull Request를 생성합니다.

## 라이선스

이 프로젝트는 MIT 라이선스에 따라 배포됩니다. 자세한 내용은 [LICENSE](LICENSE) 파일을 참조하세요.

## 연락처

프로젝트 링크: [https://github.com/code-grove/BluetoothCadence](https://github.com/code-grove/BluetoothCadence)
