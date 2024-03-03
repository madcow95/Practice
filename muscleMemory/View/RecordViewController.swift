//
//  RecordViewController.swift
//  muscleMemory
//
//  Created by MadCow on 2024/2/29.
//

import UIKit

class RecordViewController: UIViewController {
    
    let viewModel = RecordViewModel()
    
    var workoutName: [String] = RecordViewModel().getFirstWorkoutNames()
    var workoutDetail: [String] = ["대분류를 먼저 선택해주세요."]
    
    private let firstPicker: UIPickerView = {
        let picker = UIPickerView()
        
        return picker
    }()
    
    private let secondPicker: UIPickerView = {
        let picker = UIPickerView()
        
        return picker
    }()
    
    private let firstTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "   First"
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 10
        
        return tf
    }()
    
    private let secondTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "   Second"
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 10
        
        return tf
    }()
    
    private let hStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    private let stackToolBar: UIToolbar = {
        let tb = UIToolbar()
        tb.sizeToFit()
        
        return tb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        hStack.addArrangedSubview(firstTextField)
        hStack.addArrangedSubview(secondTextField)
        view.addSubview(hStack)
        hStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        hStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        hStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        
        firstPicker.delegate = self
        firstPicker.dataSource = self
        secondPicker.delegate = self
        secondPicker.dataSource = self
        
        let setFirstTF = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(setToFirstTextField))
        let buttonSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let cancelBtn = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(cancelToolbarButton))
        stackToolBar.setItems([cancelBtn, buttonSpace, setFirstTF], animated: true)
        stackToolBar.isUserInteractionEnabled = true
        
        firstTextField.inputView = firstPicker
        secondTextField.inputView = secondPicker
        firstTextField.inputAccessoryView = stackToolBar
        secondTextField.inputAccessoryView = stackToolBar
    }
    
    @objc func setToFirstTextField() {
        print("done!")
    }
    
    @objc func cancelToolbarButton() {
        print("cancel!")
    }
}

extension RecordViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == firstPicker {
            return workoutName.count // 첫 번째 UIPickerView의 데이터 수 반환
        } else {
            return workoutDetail.count // 두 번째 UIPickerView의 데이터 수 반환
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == firstPicker {
            return workoutName[row] // 첫 번째 UIPickerView의 각 행에 대한 텍스트 반환
        } else {
            return workoutDetail[row] // 두 번째 UIPickerView의 각 행에 대한 텍스트 반환
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == firstPicker {
            let selectedOption = workoutName[row] // 선택된 옵션 가져오기
            print(selectedOption)
        } else {
            let selectedOption = workoutDetail[row] // 선택된 옵션 가져오기
            print(selectedOption)
        }
    }
}
