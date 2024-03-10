//
//  WorkoutRecordViewController.swift
//  muscleMemory
//
//  Created by MadCow on 2024/3/10.
//

import UIKit

class WorkoutRecordViewController: UIViewController {
    
    let viewModel = WorkoutRecordViewModel()
    
    var workoutName: [WorkOut] = WorkoutRecordViewModel().getFirstWorkoutNames().sorted{$0.key < $1.key}
    var workoutDetail: [WorkOutDetail] = []
    var firstWorkout = WorkOut(key: 1, name: "하체")
    var secondWorkout: WorkOutDetail? = nil
    
    var stackViews: [SetEnterStack] = []
    
    private let contentScrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        return sv
    }()
    
    private let contentView: UIView = {
        let uv = UIView()
        uv.translatesAutoresizingMaskIntoConstraints = false
        
        return uv
    }()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // contentScrollView.contentSize = self.view.frame.size
        self.view.addSubview(contentScrollView)
        contentScrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        contentScrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        contentScrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        contentScrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        contentScrollView.addSubview(contentView)
        contentView.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: contentScrollView.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: contentScrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: view.frame.height*10).isActive = true
        
        let textFieldHorizontalStack = CustomHorizontalStack()
        textFieldHorizontalStack.addArrangedSubview(firstTextField)
        textFieldHorizontalStack.addArrangedSubview(secondTextField)
        contentView.addSubview(textFieldHorizontalStack)
        textFieldHorizontalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        textFieldHorizontalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        textFieldHorizontalStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100).isActive = true
        view.bringSubviewToFront(contentView)
        
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
        // keyboard 숨김 기능
        secondTextField.resignFirstResponder()
    }
    
    @objc func cancelToolbarButton() {
        secondTextField.resignFirstResponder()
    }
    
    func configureStackViews(customStack: SetEnterStack, standardView: UIView) {
        contentView.addSubview(customStack)
        customStack.topAnchor.constraint(equalTo: standardView.bottomAnchor, constant: 20).isActive = true
        customStack.leadingAnchor.constraint(equalTo: standardView.leadingAnchor).isActive = true
        customStack.trailingAnchor.constraint(equalTo: standardView.trailingAnchor).isActive = true
        customStack.tag = stackViews.count
        stackViews.append(customStack)
        
        // contentView.heightAnchor.constraint(equalToConstant: view.frame.height + CGFloat(50 * stackViews.count)).isActive = true
        view.reloadInputViews()
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

extension WorkoutRecordViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
