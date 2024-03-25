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
    
    // MARK: - Scroll View Deprecated 2024-03-14
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
        
        // setScrollComponents()
        setContentComponents() // Content View 화면에 배치
        setUIComponents() // Text Field 화면에 배치
        setCancelSaveButtonComponents() // 취소, 저장 버튼 목록 화면에 배치
        setPickerComponents() // UIPickerView delegate, dataSource 설정
        setTextFieldsComponents() // UIPickerView Text Field에 배치
        setToolbarsComponents() // UIPickerView에 취소, 저장 버튼 Tool Bar 배치
        setWorkoutsComponents() // Workout 초기값 배치
        setStackViewComponents(stack: SetRecordHorizontalStack(), standard: textFieldHStack) // 세트 입력 가능한 Stack View 화면에 배치
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
        view.addSubview(contentView)
        contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        // contentView.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        contentView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    func setUIComponents() {
        textFieldHStack.addArrangedSubview(firstTextField)
        textFieldHStack.addArrangedSubview(secondTextField)
        contentView.addSubview(textFieldHStack)
        
        textFieldHStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100).isActive = true
        textFieldHStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        textFieldHStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
    }
    
    func setCancelSaveButtonComponents() {
        let buttonStack = SaveButtonHorizonStack()
        contentView.addSubview(buttonStack)
        buttonStack.leadingAnchor.constraint(equalTo: firstTextField.leadingAnchor).isActive = true
        buttonStack.trailingAnchor.constraint(equalTo: secondTextField.trailingAnchor).isActive = true
        buttonStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        
        let cancelButton = buttonStack.arrangedSubviews[0] as! CustomButton
        let saveButton = buttonStack.arrangedSubviews[1] as! CustomButton
        
        cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
    }
    
    @objc func cancelAction() {
        dismiss(animated: true)
    }
    
    @objc func saveAction() {
        viewModel.saveWorkoutRecord(stack: stackViews)
    }
    
    func setPickerComponents() {
        firstPicker.delegate = self
        firstPicker.dataSource = self
        secondPicker.delegate = self
        secondPicker.dataSource = self
    }
    
    func setTextFieldsComponents() {
        firstTextField.inputView = firstPicker
        firstTextField.inputAccessoryView = firstStackToolBar
        
        secondTextField.inputView = secondPicker
        secondTextField.inputAccessoryView = secondStackToolBar
    }
    
    func setToolbarsComponents() {
        let buttonSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        let firstCancelBtn = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(firstCancelToolbarButton))
        let firstSetTF = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(setFirstTextField))
        firstStackToolBar.setItems([firstCancelBtn, buttonSpace, firstSetTF], animated: true)
        firstStackToolBar.isUserInteractionEnabled = true
        firstTextField.inputView = firstPicker
        firstTextField.inputAccessoryView = firstStackToolBar
        
        let secondCancelBtn = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(secondCancelToolbarButton))
        let secondSetTF = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(setSecondTextField))
        secondStackToolBar.setItems([secondCancelBtn, buttonSpace, secondSetTF], animated: true)
        secondStackToolBar.isUserInteractionEnabled = true
        secondTextField.inputView = secondPicker
        secondTextField.inputAccessoryView = secondStackToolBar
    }
    
    func setWorkoutsComponents() {
        firstWorkoutList = viewModel.getAllWorkoutData().sorted{$0.key < $1.key}
        firstWorkout = firstWorkoutList.first
    }
    
    func setStackViewComponents(stack: SetRecordHorizontalStack, standard: UIView) {
        stack.tag = stackViews.count
        stackViews.append(stack)
        // MARK: - 아직 Scroll View에 대한 이해가 낮아 무한으로 추가하는게 아닌 6개로 제한함 -> 공부 후 수정해야해 ㅠㅠ
        if stackViews.count <= 6 {
            contentView.addSubview(stack)
            stack.topAnchor.constraint(equalTo: standard.bottomAnchor, constant: 20).isActive = true
            stack.leadingAnchor.constraint(equalTo: standard.leadingAnchor).isActive = true
            stack.trailingAnchor.constraint(equalTo: standard.trailingAnchor).isActive = true

            let plusBtn = stack.arrangedSubviews[3] as! UIButton
            plusBtn.addTarget(self, action: #selector(addStackViews), for: .touchUpInside)

            if stackViews.count == 6 {
                plusBtn.backgroundColor = .lightGray
                plusBtn.isEnabled = false
            }
        }
    }
    
    // MARK: 세트를 입력하는 Stack을 추가할 때 이전 Stack의 버튼을 비활성화 -> 중간에 끼워 넣는 방식으로 해도 될거같긴 한데..?
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
    
    @objc func firstCancelToolbarButton() {
        firstTextField.resignFirstResponder()
    }
    
    @objc func secondCancelToolbarButton() {
        secondTextField.resignFirstResponder()
    }
    
    @objc func addStackViews() {
        let customStack = SetRecordHorizontalStack()
        let label = customStack.arrangedSubviews[0] as! UILabel
        
        label.text = "\(stackViews.count + 1)세트"
        let beforeStack = stackViews[stackViews.count - 1]
        disableBeforeButton(stack: beforeStack)
        // standardView.arrangedSubviews[3].isHidden = true
        
        setStackViewComponents(stack: customStack, standard: beforeStack)
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
