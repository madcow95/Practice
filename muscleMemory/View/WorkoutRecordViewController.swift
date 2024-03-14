//
//  WorkoutRecordViewController.swift
//  muscleMemory
//
//  Created by MadCow on 2024/3/10.
//

import UIKit

class WorkoutRecordViewController: UIViewController {
    
    let viewModel = WorkoutRecordViewModel()
    
    var firstWorkoutList: [WorkOut] = []
    var secondWorkoutList: [WorkOutDetail] = []
    var firstWorkout: WorkOut?
    var secondWorkout: WorkOutDetail? = nil
    var stackViews: [SetRecordHorizontalStack] = []
    
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
    
    private let textFieldHStack: CustomHorizontalStack = {
        let stack = CustomHorizontalStack()
        
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setScrollComponents()
        setContentComponents()
        setUIComponents()
        setPickerComponents()
        setTextFields()
        setToolbars()
        setWorkouts()
        setStackViews(stack: SetRecordHorizontalStack(), standard: textFieldHStack)
    }
    
    func setScrollComponents() {
        self.view.addSubview(contentScrollView)
        contentScrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        contentScrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        contentScrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        contentScrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        contentScrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
    }
    
    func setContentComponents() {
        contentScrollView.addSubview(contentView)
        contentView.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: contentScrollView.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: contentScrollView.topAnchor).isActive = true
        // contentView.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor).isActive = true
        contentView.heightAnchor.constraint(equalTo: contentScrollView.heightAnchor).isActive = true
    }
    
    func setUIComponents() {
        textFieldHStack.addArrangedSubview(firstTextField)
        textFieldHStack.addArrangedSubview(secondTextField)
        contentView.addSubview(textFieldHStack)
        
        textFieldHStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100).isActive = true
        textFieldHStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        textFieldHStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
    }
    
    func setPickerComponents() {
        firstPicker.delegate = self
        firstPicker.dataSource = self
        secondPicker.delegate = self
        secondPicker.dataSource = self
    }
    
    func setTextFields() {
        firstTextField.inputView = firstPicker
        firstTextField.inputAccessoryView = firstStackToolBar
        
        secondTextField.inputView = secondPicker
        secondTextField.inputAccessoryView = secondStackToolBar
    }
    
    func setToolbars() {
        let buttonSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let cancelBtn = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(cancelToolbarButton))
        
        let firstSetTF = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(setFirstTextField))
        firstStackToolBar.setItems([cancelBtn, buttonSpace, firstSetTF], animated: true)
        firstStackToolBar.isUserInteractionEnabled = true
        firstTextField.inputView = firstPicker
        firstTextField.inputAccessoryView = firstStackToolBar
        
        let secondSetTF = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(setSecondTextField))
        secondStackToolBar.setItems([cancelBtn, buttonSpace, secondSetTF], animated: true)
        secondStackToolBar.isUserInteractionEnabled = true
        secondTextField.inputView = secondPicker
        secondTextField.inputAccessoryView = secondStackToolBar
    }
    
    func setWorkouts() {
        firstWorkoutList = viewModel.getFirstWorkoutNames().sorted{$0.key < $1.key}
        firstWorkout = firstWorkoutList.first
    }
    
    func setStackViews(stack: SetRecordHorizontalStack, standard: UIView) {
        stack.tag = stackViews.count
        stackViews.append(stack)
        if stackViews.count <= 7 {
            contentView.addSubview(stack)
            stack.topAnchor.constraint(equalTo: standard.bottomAnchor, constant: 20).isActive = true
            stack.leadingAnchor.constraint(equalTo: standard.leadingAnchor).isActive = true
            stack.trailingAnchor.constraint(equalTo: standard.trailingAnchor).isActive = true

            let plusBtn = stack.arrangedSubviews[3] as! UIButton
            plusBtn.addTarget(self, action: #selector(addStackViews), for: .touchUpInside)

            if stackViews.count == 7 {
                plusBtn.backgroundColor = .lightGray
                plusBtn.isEnabled = false
            }
        }
    }
    
    func disableBeforeButton(stack: SetRecordHorizontalStack) {
        let beforePlusBtn = stack.arrangedSubviews[3] as! UIButton
        beforePlusBtn.backgroundColor = .lightGray
        beforePlusBtn.isEnabled = false
    }
    
    @objc func setFirstTextField() {
        guard let firstWork = firstWorkout else { return }
        firstTextField.text = firstWork.name
        
        secondTextField.text = ""
        secondPicker.selectRow(0, inComponent: 0, animated: false)
        firstTextField.resignFirstResponder()
        
        let workoutList = viewModel.getSecondWOrkoutRecordBy(workout: firstWork)
        if workoutList.count > 0 {
            secondWorkoutList = workoutList.sorted{ $0.key < $1.key }
            secondWorkout = secondWorkoutList.first
        }
    }
    
    @objc func setSecondTextField() {
        if firstWorkout != nil {
            guard let secondWork = secondWorkout else { return }
            secondTextField.text = secondWork.name
            // keyboard 숨김 기능
            secondTextField.resignFirstResponder()
        }
    }
    
    @objc func cancelToolbarButton() {
        secondTextField.resignFirstResponder()
    }
    
    @objc func addStackViews() {
        if stackViews.count != 7 {
            let customStack = SetRecordHorizontalStack()
            let label = customStack.arrangedSubviews[0] as! UILabel
            
            label.text = "\(stackViews.count + 1)세트"
            let beforeStack = stackViews[stackViews.count - 1]
            disableBeforeButton(stack: beforeStack)
            // standardView.arrangedSubviews[3].isHidden = true
            
            setStackViews(stack: customStack, standard: beforeStack)
        }
    }
}

extension WorkoutRecordViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == firstPicker {
            return firstWorkoutList.count // 첫 번째 UIPickerView의 데이터 수 반환
        } else {
            return secondWorkoutList.count // 두 번째 UIPickerView의 데이터 수 반환
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == firstPicker {
            return firstWorkoutList[row].name // 첫 번째 UIPickerView의 각 행에 대한 텍스트 반환
        } else {
            return secondWorkoutList[row].name // 두 번째 UIPickerView의 각 행에 대한 텍스트 반환
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == firstPicker {
            firstWorkout = firstWorkoutList[row] // 선택된 옵션 가져오기
        } else {
            secondWorkout = secondWorkoutList[row] // 선택된 옵션 가져오기
        }
    }
}
