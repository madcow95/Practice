//
//  ViewModel.swift
//  BluetoothTest_1
//
//  Created by MadCow on 2025/2/15.
//

import Foundation
import CoreBluetooth

class BTViewModel: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate, ObservableObject {
    var options: [String] = ["기기 찾기"]
    @Published var deviceNames: [String] = []
    @Published var connectedDeviceName: String = ""
    @Published var beatRate: String = ""
    
    private let heartRateServiceUUID = CBUUID(string: "180D") // 심박수 서비스 UUID
    private let heartRateMeasurementUUID = CBUUID(string: "2A37") // 심박수 측정 값 UUID
    private var centralManager: CBCentralManager!
    private var connectedPeripheral: CBPeripheral?
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    deinit {
        self.disConnect()
    }
    
    func connectDevice() {
        centralManager.scanForPeripherals(withServices: nil, options: nil)
    }
    
    func disConnect() {
        if let peripheral = connectedPeripheral {
            centralManager.cancelPeripheralConnection(peripheral)
            connectedPeripheral = nil
            connectedDeviceName = ""
        }
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            print("powerOn")
            startDeviceSearch()
        case .poweredOff:
            print("powerOff")
        case .resetting:
            print("resetting")
        case .unauthorized:
            print("unauthorized")
        case .unknown:
            print("unknown")
        case .unsupported:
            print("unsupported")
        default:
            break
        }
    }
    
    func startDeviceSearch() {
        if centralManager.state == .poweredOn {
            centralManager.scanForPeripherals(withServices: [], options: nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if let name = peripheral.name {
            if !deviceNames.contains(name) {
                deviceNames.append(name)
            }
        }
    }
    
    func connectToDevice(name: String) {
        if let peripheral = centralManager.retrieveConnectedPeripherals(withServices: [heartRateServiceUUID]).first(where: { $0.name == name }) {
            centralManager.connect(peripheral, options: nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("\(peripheral.name ?? "Unknown Device") connected!")
        connectedPeripheral = peripheral
        connectedDeviceName = peripheral.name ?? "Unknown"
        
        peripheral.delegate = self
        peripheral.discoverServices([heartRateServiceUUID])
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }
        
        for service in services where service.uuid == heartRateServiceUUID {
            peripheral.discoverCharacteristics([heartRateMeasurementUUID], for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else { return }
        
        for characteristic in characteristics where characteristic.uuid == heartRateMeasurementUUID {
            peripheral.setNotifyValue(true, for: characteristic)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        guard characteristic.uuid == heartRateMeasurementUUID, let data = characteristic.value else { return }
        
        let heartRate = parseHeartRate(from: data)
        DispatchQueue.main.async {
            self.beatRate = "\(heartRate)"
        }
    }
    
    private func parseHeartRate(from data: Data) -> Int {
        let byteArray = [UInt8](data)
        if byteArray.isEmpty {
            return 0
        }
        
        let flag = byteArray[0]
        let format = flag & 0x01
        
        if format == 0 {
            return Int(byteArray[1])
        } else {
            return Int(UInt16(byteArray[1]) | (UInt16(byteArray[2]) << 8))
        }
    }
}
