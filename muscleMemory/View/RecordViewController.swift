//
//  RecordViewController.swift
//  muscleMemory
//
//  Created by MadCow on 2024/2/29.
//

import UIKit

class RecordViewController: UIViewController {
    
    let data = ["Option 1", "Option 2", "Option 3", "Option 4", "Option 5"]
    let data2 = ["Option 11", "Option 22", "Option 33", "Option 44", "Option 55"]
    
    @IBOutlet weak var firstPicker: UIPickerView!
    @IBOutlet weak var secondPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        firstPicker?.delegate = self
        firstPicker?.dataSource = self
        
        secondPicker?.delegate = self
        secondPicker?.dataSource = self
    }
}

extension RecordViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == firstPicker {
            return data.count
        } else {
            return data2.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == firstPicker {
            return data[row]
        } else {
            return data2[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == firstPicker {
            let selectedOption = data[row] // 선택된 옵션 가져오기
            print(selectedOption)
        } else {
            let selectedOption = data2[row] // 선택된 옵션 가져오기
            print(selectedOption)
        }
    }
}
