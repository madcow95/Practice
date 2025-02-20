//
//  BluetoothCadenceTests.swift
//  BluetoothCadenceTests
//
//  Created by Jungman Bae on 7/29/24.
//

import XCTest
import CoreBluetooth
@testable import BluetoothCadence

class MockCBCentralManager: CBCentralManager {
    var mockState: CBManagerState = .poweredOn
    
    override var state: CBManagerState {
        return mockState
    }
    
    override func scanForPeripherals(withServices serviceUUIDs: [CBUUID]?, options: [String : Any]? = nil) {
        // 스캔 시작을 시뮬레이션합니다.
    }
}

class MockCBPeripheral: CBPeripheral {
    var mockName: String?
    
    override var name: String? {
        return mockName
    }
}

class MockBluetoothManagerDelegate: BluetoothManagerDelegate {
    var didUpdateConnectionState = false
    var didUpdateCadence = false
    var didUpdateSpeed = false
    var didUpdateDistance = false
    var didUpdateBatteryLevel = false
    var didReceiveError = false
    
    func bluetoothManager(_ manager: BluetoothManager, didUpdateConnectionState isConnected: Bool) {
        didUpdateConnectionState = true
    }
    
    func bluetoothManager(_ manager: BluetoothManager, didUpdateCadence cadence: Double) {
        didUpdateCadence = true
    }
    
    func bluetoothManager(_ manager: BluetoothManager, didUpdateSpeed speed: Double) {
        didUpdateSpeed = true
    }
    
    func bluetoothManager(_ manager: BluetoothManager, didUpdateDistance distance: Double) {
        didUpdateDistance = true
    }
    
    func bluetoothManager(_ manager: BluetoothManager, didUpdateBatteryLevel batteryLevel: Int) {
        didUpdateBatteryLevel = true
    }
    
    func bluetoothManager(_ manager: BluetoothManager, didReceiveError error: Error) {
        didReceiveError = true
    }
}

final class BluetoothCadenceTests: XCTestCase {
    var bluetoothManager: BluetoothManager!
    var mockCentralManager: MockCBCentralManager!
    var mockDelegate: MockBluetoothManagerDelegate!

    override func setUpWithError() throws {
        mockCentralManager = MockCBCentralManager()
        bluetoothManager = BluetoothManager(wheelSize: 2000)
        mockDelegate = MockBluetoothManagerDelegate()
        bluetoothManager.delegate = mockDelegate
    }

    override func tearDownWithError() throws {
        bluetoothManager = nil
        mockCentralManager = nil
        mockDelegate = nil
    }

    func testBluetoothManagerInitialization() {
        XCTAssertNotNil(bluetoothManager)
        XCTAssertEqual(bluetoothManager.isConnected, false)
        XCTAssertEqual(bluetoothManager.cadence, 0)
        XCTAssertEqual(bluetoothManager.speed, 0)
        XCTAssertEqual(bluetoothManager.distance, 0)
        XCTAssertEqual(bluetoothManager.batteryLevel, 0)
    }
    
//    func testStartScanning() {
//        bluetoothManager.startScanning()
//        // 실제로 스캔이 시작되었는지 확인하는 방법은 제한적이지만,
//        // 최소한 에러가 발생하지 않았는지 확인할 수 있습니다.
//        XCTAssertFalse(mockDelegate.didReceiveError)
//    }
    
    func testCalculateCadence() {
        // 이 테스트는 private 메서드를 테스트하므로, 실제 구현에서는 작동하지 않을 수 있습니다.
        // 필요하다면 calculateCadence 메서드를 internal로 변경하거나 테스트 전용 메서드를 추가해야 합니다.
        bluetoothManager.calculateCadence(newCrankRevolutions: 10, newCrankEventTime: 1024)
        bluetoothManager.calculateCadence(newCrankRevolutions: 20, newCrankEventTime: 2048)
        
        XCTAssertTrue(mockDelegate.didUpdateCadence)
        XCTAssertGreaterThan(bluetoothManager.cadence, 0)
    }
    
    func testCalculateSpeed() {
        // 마찬가지로 private 메서드 테스트입니다.
        bluetoothManager.calculateSpeed(newWheelRevolutions: 10, newWheelEventTime: 1024)
        bluetoothManager.calculateSpeed(newWheelRevolutions: 20, newWheelEventTime: 2048)
        
        XCTAssertTrue(mockDelegate.didUpdateSpeed)
        XCTAssertTrue(mockDelegate.didUpdateDistance)
        XCTAssertGreaterThan(bluetoothManager.speed, 0)
        XCTAssertGreaterThan(bluetoothManager.distance, 0)
    }
    
    func testParseBatteryData() {
        let batteryData = Data([50]) // 50% 배터리
        bluetoothManager.parseBatteryData(batteryData)
        
        XCTAssertTrue(mockDelegate.didUpdateBatteryLevel)
        XCTAssertEqual(bluetoothManager.batteryLevel, 50)
    }
}
