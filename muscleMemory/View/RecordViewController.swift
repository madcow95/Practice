//
//  RecordViewController.swift
//  muscleMemory
//
//  Created by MadCow on 2024/2/29.
//

import UIKit

class RecordViewController: UIViewController {
    
    let viewModel = RecordViewModel()
    
    var workoutName: [WorkOut] = RecordViewModel().getFirstWorkoutNames().sorted{$0.key < $1.key}
    var workoutDetail: [WorkOutDetail] = []
    var firstWorkout = WorkOut(key: 1, name: "하체")
    var secondWorkout: WorkOutDetail? = nil
    
    var stackViews: [SetEnterStack] = []
    
    private let firstPicker: UIPickerView = {
        let picker = UIPickerView()
        
        return picker
    }()
    
    private let secondPicker: UIPickerView = {
        let picker = UIPickerView()
        
        return picker
    }()
    
    private let firstTextField: CustomTextField = {
        let tf = CustomTextField()
        tf.placeholder = "First"
        
        return tf
    }()
    
    private let secondTextField: CustomTextField = {
        let tf = CustomTextField()
        tf.placeholder = "Second"
        
        return tf
    }()
    
    private let firstStackToolBar: UIToolbar = {
        let tb = UIToolbar()
        tb.sizeToFit()
        
        return tb
    }()
    
    private let secondStackToolBar: UIToolbar = {
        let tb = UIToolbar()
        tb.sizeToFit()
        
        return tb
    }()
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        return sv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.contentSize = view.frame.size
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        let textFieldHorizontalStack = CustomHorizontalStack()
        textFieldHorizontalStack.addArrangedSubview(firstTextField)
        textFieldHorizontalStack.addArrangedSubview(secondTextField)
        scrollView.addSubview(textFieldHorizontalStack)
        textFieldHorizontalStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20).isActive = true
        textFieldHorizontalStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20).isActive = true
        textFieldHorizontalStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 200).isActive = true
        
        firstPicker.delegate = self
        firstPicker.dataSource = self
        secondPicker.delegate = self
        secondPicker.dataSource = self
        
        let buttonSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let cancelBtn = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(cancelToolbarButton))
        
        let firstSetTF = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(setToFirstTextField))
        firstStackToolBar.setItems([cancelBtn, buttonSpace, firstSetTF], animated: true)
        firstStackToolBar.isUserInteractionEnabled = true
        firstTextField.inputView = firstPicker
        firstTextField.inputAccessoryView = firstStackToolBar
        
        let secondSetTF = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(setToSecondTextField))
        secondStackToolBar.setItems([cancelBtn, buttonSpace, secondSetTF], animated: true)
        secondStackToolBar.isUserInteractionEnabled = true
        secondTextField.inputView = secondPicker
        secondTextField.inputAccessoryView = secondStackToolBar
        
        let customStack = SetEnterStack()
        configureStackViews(customStack: customStack, standardView: textFieldHorizontalStack)
    }
    
    @objc func setToFirstTextField() {
        
        firstTextField.text = firstWorkout.name
        secondTextField.text = ""
        secondPicker.selectRow(0, inComponent: 0, animated: false)
        firstTextField.resignFirstResponder()
        
        let workoutList = viewModel.getSecondWOrkoutRecordBy(workout: firstWorkout)
        if workoutList.count > 0 {
            workoutDetail = workoutList
        }
    }
    
    @objc func setToSecondTextField() {
        
        if let secondTF = secondWorkout {
            secondTextField.text = secondTF.name
        }
        secondTextField.resignFirstResponder()
    }
    
    @objc func cancelToolbarButton() {
        secondTextField.resignFirstResponder()
    }
    
    func configureStackViews(customStack: SetEnterStack, standardView: UIView) {
        scrollView.addSubview(customStack)
        customStack.topAnchor.constraint(equalTo: standardView.bottomAnchor, constant: 20).isActive = true
        customStack.leadingAnchor.constraint(equalTo: standardView.leadingAnchor).isActive = true
        customStack.trailingAnchor.constraint(equalTo: standardView.trailingAnchor).isActive = true
        customStack.tag = stackViews.count
        stackViews.append(customStack)
        
        let plusBtn = customStack.arrangedSubviews[3] as! UIButton
        plusBtn.addTarget(self, action: #selector(addStackViews), for: .touchUpInside)
    }
    
    @objc func addStackViews() {
        let customStack = SetEnterStack()
        
        let label = customStack.arrangedSubviews[0] as! UILabel
        // let plusBtn = customStack.arrangedSubviews[3] as! UIButton
        
        label.text = "\(stackViews.count + 1)세트"
        let standardView = stackViews[stackViews.count - 1]
        let beforePlusBtn = standardView.arrangedSubviews[3] as! UIButton
        beforePlusBtn.backgroundColor = .lightGray
        beforePlusBtn.isEnabled = false
        // standardView.arrangedSubviews[3].isHidden = true
        
        configureStackViews(customStack: customStack, standardView: standardView)
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
            return workoutName[row].name // 첫 번째 UIPickerView의 각 행에 대한 텍스트 반환
        } else {
            return workoutDetail[row].name // 두 번째 UIPickerView의 각 행에 대한 텍스트 반환
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == firstPicker {
            firstWorkout = workoutName[row] // 선택된 옵션 가져오기
        } else {
            secondWorkout = workoutDetail[row] // 선택된 옵션 가져오기
        }
    }
}
