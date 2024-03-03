//
//  RecordViewController.swift
//  muscleMemory
//
//  Created by MadCow on 2024/2/29.
//

import UIKit

class WorkoutRecordViewController: UIViewController {
    
    let data1 = ["Option 1", "Option 2", "Option 3", "Option 4", "Option 5"]
    let data2 = ["Option 11", "Option 22", "Option 33", "Option 44", "Option 55"]
    
//    private let firstPicker: UIPickerView = {
//        let picker = UIPickerView()
//
//        return picker
//    }()
//
//    private let secondPicker: UIPickerView = {
//        let picker = UIPickerView()
//
//        return picker
//    }()
    
    private let firstTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "First"
        
        return tf
    }()
    
    private let secondTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Second"
        
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.alignment = .center
        hStack.distribution = .equalSpacing
        
        hStack.addArrangedSubview(firstTextField)
        hStack.addArrangedSubview(secondTextField)
        
        hStack.translatesAutoresizingMaskIntoConstraints = false
        hStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        hStack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
//        firstPicker.delegate = self
//        firstPicker.dataSource = self
//
//        secondPicker.delegate = self
//        secondPicker.dataSource = self
    }
}

//extension RecordViewController: UIPickerViewDelegate, UIPickerViewDataSource {
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        if pickerView == firstPicker {
//            return data1.count // 첫 번째 UIPickerView의 데이터 수 반환
//        } else {
//            return data2.count // 두 번째 UIPickerView의 데이터 수 반환
//        }
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        if pickerView == firstPicker {
//            return data1[row] // 첫 번째 UIPickerView의 각 행에 대한 텍스트 반환
//        } else {
//            return data2[row] // 두 번째 UIPickerView의 각 행에 대한 텍스트 반환
//        }
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        if pickerView == firstPicker {
//            let selectedOption = data1[row] // 선택된 옵션 가져오기
//            print(selectedOption)
//        } else {
//            let selectedOption = data2[row] // 선택된 옵션 가져오기
//            print(selectedOption)
//        }
//    }
//}
