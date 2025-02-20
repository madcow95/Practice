//
//  BluetoothManager.swift
//  BluetoothCadence
//
//  Created by Jungman Bae on 7/29/24.
//

import Foundation
import CoreBluetooth
import os

// MARK: - BluetoothManager Class

public class BluetoothManager: NSObject {
    // MARK: - Public properties
    
    public weak var delegate: BluetoothManagerDelegate?
    
    public private(set) var isConnected: Bool = false {
        didSet {
            delegate?.bluetoothManager(self, didUpdateConnectionState: isConnected)
        }
    }
    
    public private(set) var cadence: Double = 0 {
        didSet {
            delegate?.bluetoothManager(self, didUpdateCadence: cadence)
        }
    }
    
    public private(set) var speed: Double = 0 {
        didSet {
            delegate?.bluetoothManager(self, didUpdateSpeed: speed)
        }
    }
    
    public private(set) var distance: Double = 0 {
        didSet {
            delegate?.bluetoothManager(self, didUpdateDistance: distance)
        }
    }
    
    public private(set) var batteryLevel: Int = 0 {
        didSet {
            delegate?.bluetoothManager(self, didUpdateBatteryLevel: batteryLevel)
        }
    }
    
    public private(set) var connectedSensorName: String?
    public private(set) var lastDataReceivedTime: Date?
    public private(set) var rssi: Int = 0
    
    // MARK: - Private properties
    
    private var centralManager: CBCentralManager!
    private var cadenceSensor: CBPeripheral?
    private var characteristics: [CBUUID: CBCharacteristic] = [:]
    
    private var lastWheelRevolutions: UInt32?
    private var lastWheelEventTime: UInt16?
    private var lastCrankRevolutions: UInt16?
    private var lastCrankEventTime: UInt16?
    
    private let wheelCircumference: UInt32
    
    // Service UUIDs
    private let cyclingSpeedCadenceServiceUUID = CBUUID(string: "1816")
    private let deviceInfoServiceUUID = CBUUID(string: "180A")
    private let batteryServiceUUID = CBUUID(string: "180F")
    
    // Characteristic UUIDs
    private let batteryLevelCharacteristicUUID = CBUUID(string: "2A19")
    private let cscFeatureCharacteristicUUID = CBUUID(string: "2A5C")
    private let cscMeasurementCharacteristicUUID = CBUUID(string: "2A5B")
    private let sensorLocationCharacteristicUUID = CBUUID(string: "2A5D")
    
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "BluetoothManager")
    
    
    // MARK: - Initialization
    
    public init(wheelSize: UInt32? = nil) {
        self.wheelCircumference = wheelSize ?? BTConstants.DefaultWheelSize
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
        logger.info("BluetoothManager initialized with wheel size: \(self.wheelCircumference)mm")
    }

    // MARK: - Public methods
    
    public func startScanning() {
        guard centralManager.state == .poweredOn else {
            delegate?.bluetoothManager(self, didReceiveError: BluetoothManagerError.bluetoothPoweredOff)
            return
        }
        
        centralManager.scanForPeripherals(withServices: [cyclingSpeedCadenceServiceUUID])
        logger.info("Started scanning for CSC service")
    }
    
    public func stopScanning() {
        centralManager.stopScan()
        logger.info("Stopped scanning")
    }
    
    public func disconnect() {
        if let sensor = cadenceSensor {
            centralManager.cancelPeripheralConnection(sensor)
        }
    }
    
    // MARK: - Private methods
    
    private func parseCscMeasurement(_ data: Data) {
        guard data.count >= 1 else {
            logger.error("CSC Measurement data is too short: \(data.count) bytes")
            return
        }
        
        let flags = data[0]
        let wheelRevolutionDataPresent = flags & 0x01 != 0
        let crankRevolutionDataPresent = flags & 0x02 != 0
        
        var index = 1
        
        if wheelRevolutionDataPresent && data.count >= index + 6 {
            let wheelRevolutions = UInt32(data[index]) | UInt32(data[index+1]) << 8 | UInt32(data[index+2]) << 16 | UInt32(data[index+3]) << 24
            index += 4
            let wheelEventTime = UInt16(data[index]) | UInt16(data[index+1]) << 8
            index += 2
            
            calculateSpeed(newWheelRevolutions: wheelRevolutions, newWheelEventTime: wheelEventTime)
        }
        
        if crankRevolutionDataPresent && data.count >= index + 4 {
            let crankRevolutions = UInt16(data[index]) | UInt16(data[index+1]) << 8
//            let crankRevolutions = UInt16(littleEndian: data[index..<index+2].withUnsafeBytes { $0.load(as: UInt16.self) })
            index += 2
            let crankEventTime = UInt16(data[index]) | UInt16(data[index+1]) << 8
//            let crankEventTime = UInt16(littleEndian: data[index..<index+2].withUnsafeBytes { $0.load(as: UInt16.self) })
            index += 2
            
            calculateCadence(newCrankRevolutions: crankRevolutions, newCrankEventTime: crankEventTime)
        }
        
        lastDataReceivedTime = Date()
    }
    
    internal func calculateSpeed(newWheelRevolutions: UInt32, newWheelEventTime: UInt16) {
        print("newWheelRevolutions, newWheelEventTime >>> ", newWheelRevolutions, newWheelEventTime)
        guard let lastWheelRevolutions = self.lastWheelRevolutions,
              let lastWheelEventTime = self.lastWheelEventTime else {
            self.lastWheelRevolutions = newWheelRevolutions
            self.lastWheelEventTime = newWheelEventTime
            return
        }
        
        /*
         &+: 오버플로우를 허용하는 덧셈 연산자
         &-: 오버플로우를 허용하는 뺄셈 연산자
         &*: 오버플로우를 허용하는 곱셈 연산자
         */
        let revDiff = (newWheelRevolutions &- lastWheelRevolutions) & 0xFFFFFFFF
        let timeDiff = (UInt32(newWheelEventTime) &- UInt32(lastWheelEventTime)) & 0xFFFF
        
        if timeDiff > 0 {
            let distanceMeters = Double(revDiff) * Double(wheelCircumference) / 1000.0
            let timeSeconds = Double(timeDiff) / BTConstants.TimeScale
            let speedMPS = distanceMeters / timeSeconds
            
            self.speed = speedMPS
            self.distance += distanceMeters
        }
        
        self.lastWheelRevolutions = newWheelRevolutions
        self.lastWheelEventTime = newWheelEventTime
    }
    
    internal func calculateCadence(newCrankRevolutions: UInt16, newCrankEventTime: UInt16) {
        guard let lastCrankRevolutions = self.lastCrankRevolutions,
              let lastCrankEventTime = self.lastCrankEventTime else {
            self.lastCrankRevolutions = newCrankRevolutions
            self.lastCrankEventTime = newCrankEventTime
            return
        }
        
        let revDiff = (newCrankRevolutions &- lastCrankRevolutions) & 0xFFFF // (UInt32(newCrankRevolutions) - UInt32(lastCrankRevolutions)) & 0xFFFF
        let timeDiff = (UInt32(newCrankEventTime) &- UInt32(lastCrankEventTime)) & 0xFFFF
        
        if timeDiff > 0 {
            let calculatedCadence = Double(revDiff) * 60.0 * BTConstants.TimeScale / Double(timeDiff)
            self.cadence = calculatedCadence
        }
        
        self.lastCrankRevolutions = newCrankRevolutions
        self.lastCrankEventTime = newCrankEventTime
    }
    
    private func parseCscFeature(_ data: Data) {
        guard data.count >= 2 else {
            logger.error("CSC Feature data is too short: \(data.count) bytes")
            return
        }
        
        let feature = UInt16(littleEndian: data.withUnsafeBytes { $0.load(as: UInt16.self) })
        let wheelRevolutionSupported = feature & 0x01 != 0
        let crankRevolutionSupported = feature & 0x02 != 0
        let multipleSensorLocationsSupported = feature & 0x04 != 0
        
        logger.info("CSC Feature: \(String(format:"%04X", feature))")
        logger.info("Wheel Revolution: \(wheelRevolutionSupported ? "Supported" : "Not Supported")")
        logger.info("Crank Revolution: \(crankRevolutionSupported ? "Supported" : "Not Supported")")
        logger.info("Multiple Sensor Locations: \(multipleSensorLocationsSupported ? "Supported" : "Not Supported")")
    }
    
    private func parseSensorLocation(_ data: Data) {
        guard let locationValue = data.first else {
            logger.error("Sensor Location data is empty")
            return
        }
        
        let locations = [
            "Other", "Top of shoe", "In shoe", "Hip", "Front wheel", "Left crank", "Right crank",
            "Left pedal", "Right pedal", "Front hub", "Rear dropout", "Chainstay", "Rear wheel",
            "Rear hub", "Chest", "Spider", "Chain ring"
        ]
        
        let locationString = locationValue < locations.count ? locations[Int(locationValue)] : "Reserved"
        logger.info("Sensor Location: \(locationString) (Value: \(locationValue))")
    }
    
    internal func parseBatteryData(_ data: Data) {
        if let batteryLevel = data.first {
            self.batteryLevel = Int(batteryLevel)
        }
    }
}

// MARK: - CBCentralManagerDelegate

extension BluetoothManager: CBCentralManagerDelegate {
    public func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            logger.info("Bluetooth is powered on")
        case .poweredOff:
            delegate?.bluetoothManager(self, didReceiveError: BluetoothManagerError.bluetoothPoweredOff)
        case .unsupported:
            delegate?.bluetoothManager(self, didReceiveError: BluetoothManagerError.bluetoothUnsupported)
        case .unauthorized:
            delegate?.bluetoothManager(self, didReceiveError: BluetoothManagerError.bluetoothUnauthorized)
        case .resetting:
            logger.info("Bluetooth is resetting")
        case .unknown:
            logger.info("Bluetooth state is unknown")
        @unknown default:
            logger.warning("Unknown Bluetooth state")
        }
    }
    
    public func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        logger.info("Discovered peripheral: \(peripheral.name ?? "Unknown")")
        cadenceSensor = peripheral
        self.rssi = RSSI.intValue
        centralManager.stopScan()
        centralManager.connect(peripheral, options: nil)
    }
    
    public func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        logger.info("Connected to peripheral: \(peripheral.name ?? "Unknown")")
        isConnected = true
        connectedSensorName = peripheral.name
        peripheral.delegate = self
        peripheral.discoverServices([cyclingSpeedCadenceServiceUUID, batteryServiceUUID])
    }
    
    public func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        logger.error("Failed to connect to peripheral: \(error?.localizedDescription ?? "Unknown error")")
        delegate?.bluetoothManager(self, didReceiveError: BluetoothManagerError.connectionFailed)
    }
    
    public func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        logger.info("Disconnected from peripheral: \(peripheral.name ?? "Unknown")")
        isConnected = false
        connectedSensorName = nil
    }
}

// MARK: - CBPeripheralDelegate

extension BluetoothManager: CBPeripheralDelegate {
    public func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard error == nil else {
            logger.error("Error discovering services: \(error!.localizedDescription)")
            delegate?.bluetoothManager(self, didReceiveError: BluetoothManagerError.serviceNotFound)
            return
        }
        
        guard let services = peripheral.services else {
            logger.error("No services found")
            return
        }
        
        for service in services {
            logger.info("Discovered service: \(service.uuid)")
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    public func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard error == nil else {
            logger.error("Error discovering characteristics: \(error!.localizedDescription)")
            delegate?.bluetoothManager(self, didReceiveError: BluetoothManagerError.characteristicNotFound)
            return
        }
        
        guard let characteristics = service.characteristics else {
            logger.error("No characteristics found")
            return
        }
        
        for characteristic in characteristics {
            logger.info("Discovered characteristic: \(characteristic.uuid)")
            self.characteristics[characteristic.uuid] = characteristic
            
            if characteristic.properties.contains(.notify) {
                peripheral.setNotifyValue(true, for: characteristic)
            }
            
            if characteristic.properties.contains(.read) {
                peripheral.readValue(for: characteristic)
            }
        }
    }
    public func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        guard error == nil else {
            logger.error("Error updating value for characteristic: \(error!.localizedDescription)")
            return
        }
        
        guard let data = characteristic.value else {
            logger.error("No data received from characteristic")
            return
        }
        
        switch characteristic.uuid {
        case cscMeasurementCharacteristicUUID:
            parseCscMeasurement(data)
        case cscFeatureCharacteristicUUID:
            parseCscFeature(data)
        case sensorLocationCharacteristicUUID:
            parseSensorLocation(data)
        case batteryLevelCharacteristicUUID:
            parseBatteryData(data)
        default:
            logger.info("Received data for unknown characteristic: \(characteristic.uuid)")
        }
    }
    
    public func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        if let error = error {
            logger.error("Error changing notification state: \(error.localizedDescription)")
            return
        }
        
        logger.info("Notification state updated for characteristic: \(characteristic.uuid)")
    }
    
    public func peripheral(_ peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber, error: Error?) {
        if let error = error {
            logger.error("Error reading RSSI: \(error.localizedDescription)")
            return
        }
        
        self.rssi = RSSI.intValue
        logger.info("Updated RSSI: \(RSSI)")
    }
}

// MARK: - BluetoothManagerError

public enum BluetoothManagerError: Error {
    case bluetoothPoweredOff
    case bluetoothUnsupported
    case bluetoothUnauthorized
    case connectionFailed
    case serviceNotFound
    case characteristicNotFound
}

extension BluetoothManagerError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .bluetoothPoweredOff:
            return NSLocalizedString("Bluetooth is powered off", comment: "")
        case .bluetoothUnsupported:
            return NSLocalizedString("Bluetooth is not supported on this device", comment: "")
        case .bluetoothUnauthorized:
            return NSLocalizedString("Bluetooth use is not authorized", comment: "")
        case .connectionFailed:
            return NSLocalizedString("Failed to connect to the sensor", comment: "")
        case .serviceNotFound:
            return NSLocalizedString("Required Bluetooth service not found", comment: "")
        case .characteristicNotFound:
            return NSLocalizedString("Required Bluetooth characteristic not found", comment: "")
        }
    }
}

