//
//  ViewController.swift
//  CoreBluetoothTest
//
//  Created by 이병훈 on 12/18/24.
//

import CoreBluetooth
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bluetoothStateLabel: UILabel!
    
    var peripherals: [CBPeripheral] = []
    var centralManager: CBCentralManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.centralManager = CBCentralManager(delegate: self, queue: nil)
        
    }

    @IBAction func startSearchButton(_ sender: UIButton) {
        print("\(#function) - 검색시작")
        if !centralManager.isScanning {
            centralManager.scanForPeripherals(withServices: nil, options: nil)
        }
    }
    
    @IBAction func stopSearchButton(_ sender: UIButton) {
        print("\(#function) - 검색중지")
        centralManager.stopScan()
    }
    
}

extension ViewController: CBPeripheralDelegate {
    
}

extension ViewController: CBCentralManagerDelegate {
    
    // 블루투스 상태가 업데이트 되면 호출되는 함수
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .unknown:
            print("\(#function) - unknown")
        case .resetting:
            print("\(#function) - resetting")
        case .unsupported:
            print("\(#function) - unsupported")
        case .unauthorized:
            print("\(#function) - unauthorized")
        case .poweredOff:
            print("\(#function) - poweredOff")
            self.bluetoothStateLabel.text = "Bluetooth Off"
        case .poweredOn:
            print("\(#function) - poweredOn")
            self.bluetoothStateLabel.text = "Bluetooth On"
        @unknown default:
            fatalError()
        }
    }
    
    func centralManager(
        _ central: CBCentralManager,
        didDiscover peripheral: CBPeripheral,
        advertisementData: [String : Any],
        rssi RSSI: NSNumber
    ) {
        let check: Bool = false
        if !check {
            peripherals.append(peripheral)
            print("\(#function) - Discovered peripheral: \(peripheral)")
        }
    }
    
}

// MARK: CBCentralManager - [블루투스 제어]
/// 주변 블루투스 기기 검색, 연결 및 검색되거나 연결된 주변 장치 관리

// MARK: CBPeripheral - [검색되는 블루투스 기기]
/// 앱을 통해 검색하는 원격 주변 장치 UUID를 통해 자신을 식별


