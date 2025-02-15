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
    
    func connect() {
        centralManager.scanForPeripherals(withServices: nil, options: nil)
    }
    
    func disConnect() {
        
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
            centralManager.scanForPeripherals(withServices: [heartRateServiceUUID], options: nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if let name = peripheral.name {
            if !deviceNames.contains(name) {
                deviceNames.append(name)
            }
        }
    }
    
    func connect(to peripheral: CBPeripheral) {
        centralManager.stopScan()
        connectedPeripheral = peripheral
        connectedPeripheral?.delegate = self
        centralManager.connect(peripheral, options: nil)
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.discoverServices([heartRateServiceUUID])
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }
        
        for service in services {
            if service.uuid == heartRateServiceUUID {
                
//                peripheral.discoverCharacteristics([cadenceCharacteristicUUID], for: service)
                break
            }
        }
    }
}
