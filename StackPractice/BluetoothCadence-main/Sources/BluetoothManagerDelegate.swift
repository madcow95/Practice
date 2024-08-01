//
//  BluetoothManagerDelegate.swift
//  BluetoothCadence
//
//  Created by Jungman Bae on 7/29/24.
//

import Foundation

// MARK: - BluetoothManagerDelegate Protocol

public protocol BluetoothManagerDelegate: AnyObject {
    func bluetoothManager(_ manager: BluetoothManager, didUpdateConnectionState isConnected: Bool)
    func bluetoothManager(_ manager: BluetoothManager, didUpdateCadence cadence: Double)
    func bluetoothManager(_ manager: BluetoothManager, didUpdateSpeed speed: Double)
    func bluetoothManager(_ manager: BluetoothManager, didUpdateDistance distance: Double)
    func bluetoothManager(_ manager: BluetoothManager, didUpdateBatteryLevel batteryLevel: Int)
    func bluetoothManager(_ manager: BluetoothManager, didReceiveError error: Error)
}
