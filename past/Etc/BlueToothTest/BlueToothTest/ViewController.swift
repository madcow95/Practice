//
//  ViewController.swift
//  BluetoothCadence-Demo-UIKit
//
//  Created by Jungman Bae on 8/1/24.
//

import UIKit

class ViewController: UIViewController {
    private let bluetoothManager = BluetoothManager()
    
    private let statusLabel = UILabel()
    private let cadenceLabel = UILabel()
    private let speedLabel = UILabel()
    private let distanceLabel = UILabel()
    private let batteryLabel = UILabel()
    private let scanButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "BluetoothCadence Demo"
        view.backgroundColor = .white
        
        setupUI()
        bluetoothManager.delegate = self
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        let stackView = UIStackView(arrangedSubviews: [statusLabel, cadenceLabel, speedLabel, distanceLabel, batteryLabel, scanButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        statusLabel.textColor = .black
        cadenceLabel.textColor = .black
        speedLabel.textColor = .black
        distanceLabel.textColor = .black
        batteryLabel.textColor = .black
        statusLabel.text = "Status: Disconnected"
        cadenceLabel.text = "Cadence: -- rpm"
        speedLabel.text = "Speed: -- km/h"
        distanceLabel.text = "Distance: -- km"
        batteryLabel.text = "Battery: --%"
        
        scanButton.setTitle("Start Scanning", for: .normal)
        scanButton.addTarget(self, action: #selector(scanButtonTapped), for: .touchUpInside)
    }
    
    @objc private func scanButtonTapped() {
        if bluetoothManager.isConnected {
            bluetoothManager.disconnect()
            scanButton.setTitle("Start Scanning", for: .normal)
        } else {
            bluetoothManager.startScanning()
            scanButton.setTitle("Stop Scanning", for: .normal)
        }
    }
}

extension ViewController: BluetoothManagerDelegate {
    func bluetoothManager(_ manager: BluetoothManager, didUpdateConnectionState isConnected: Bool) {
        DispatchQueue.main.async {
            self.statusLabel.text = "Status: \(isConnected ? "Connected" : "Disconnected")"
            if isConnected {
                self.scanButton.setTitle("Disconnect", for: .normal)
            }
        }
    }
    
    func bluetoothManager(_ manager: BluetoothManager, didUpdateCadence cadence: Double) {
        print("cadence >> \(cadence)")
        DispatchQueue.main.async {
            self.cadenceLabel.text = String(format: "Cadence: %.1f rpm", cadence)
        }
    }
    
    func bluetoothManager(_ manager: BluetoothManager, didUpdateSpeed speed: Double) {
        print("speed >> \(speed)")
        DispatchQueue.main.async {
            self.speedLabel.text = String(format: "Speed: %.1f km/h", speed * 3.6) // Convert m/s to km/h
        }
    }
    
    func bluetoothManager(_ manager: BluetoothManager, didUpdateDistance distance: Double) {
        print("distance >> \(distance)")
        DispatchQueue.main.async {
            self.distanceLabel.text = String(format: "Distance: %.2f km", distance / 1000) // Convert meters to km
        }
    }
    
    func bluetoothManager(_ manager: BluetoothManager, didUpdateBatteryLevel batteryLevel: Int) {
        print("batteryLevel >> \(batteryLevel)")
        DispatchQueue.main.async {
            self.batteryLabel.text = "Battery: \(batteryLevel)%"
        }
    }
    
    func bluetoothManager(_ manager: BluetoothManager, didReceiveError error: Error) {
        print("error >> \(error)")
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
