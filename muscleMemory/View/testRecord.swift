//
//  testRecord.swift
//  muscleMemory
//
//  Created by MadCow on 2024/3/11.
//

import UIKit

class testRecord: UIViewController {
    
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var content: UIView!
    @IBOutlet weak var firstStackView: UIStackView!
    @IBOutlet weak var containerView: UIView!
    
    let firstPicker = UIPickerView()
    let secondPicker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurePicker()
        configureTextField()
        configureButtons()
    }
    
    func configurePicker() {
        firstPicker.delegate = self
        firstPicker.dataSource = self
        secondPicker.delegate = self
        secondPicker.dataSource = self
    }
    
    func configureTextField() {
        firstTextField.inputView = firstPicker
        // firstTextField.inputAccessoryView = firstStackToolBar
        
        secondTextField.inputView = secondPicker
        // secondTextField.inputAccessoryView = secondStackToolBar
    }
    
    func configureButtons() {
        addButton.addTarget(self, action: #selector(addStacks), for: .touchUpInside)
    }
    
    @objc func addStacks() {
        print("button tapped!")
        
        for constraint in containerView.constraints {
            if constraint.firstAnchor == content.bottomAnchor || constraint.secondAnchor == content.bottomAnchor {
                constraint.isActive = false
                break
            }
        }
        
        let hStack = CustomHorizontalStack()
        content.addSubview(hStack)
        hStack.topAnchor.constraint(equalTo: firstStackView.bottomAnchor, constant: 10).isActive = true
        hStack.leadingAnchor.constraint(equalTo: firstStackView.leadingAnchor).isActive = true
        hStack.trailingAnchor.constraint(equalTo: firstStackView.trailingAnchor).isActive = true
        hStack.bottomAnchor.constraint(equalTo: content.bottomAnchor).isActive = true
        content.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
    }
}

extension testRecord: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == firstPicker {
            return "First"
        } else {
            return "Second"
        }
    }
}
