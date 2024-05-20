//
//  MuscleMemoryCreateView.swift
//  MuscleMemory
//
//  Created by MadCow on 2024/5/13.
//

import UIKit

class MuscleMemoryCreateView: UIViewController {
    
    let createViewModel = MuscleMemoryCreateViewModel()
    
    enum WorkoutPart: String, CaseIterable {
        case chest = "가슴"
        case shoulder = "어깨"
        case back = "등"
        case legs = "하체"
        case arms = "팔"
        
        var workoutList: [String] {
            get {
                switch self {
                case .chest:
                    return MuscleMemoryCreateViewModel.chestPart
                case .shoulder:
                    return MuscleMemoryCreateViewModel.shoulderPart
                case .back:
                    return MuscleMemoryCreateViewModel.backPart
                case .legs:
                    return MuscleMemoryCreateViewModel.legsPart
                case .arms:
                    return MuscleMemoryCreateViewModel.armsPart
                }
            }
        }
        
        mutating func addWorkoutList(_ newWorkout: String) {
            switch self {
            case .chest:
                MuscleMemoryCreateViewModel.chestPart.append(newWorkout)
            case .shoulder:
                MuscleMemoryCreateViewModel.shoulderPart.append(newWorkout)
            case .back:
                MuscleMemoryCreateViewModel.backPart.append(newWorkout)
            case .legs:
                MuscleMemoryCreateViewModel.legsPart.append(newWorkout)
            case .arms:
                MuscleMemoryCreateViewModel.armsPart.append(newWorkout)
            }
        }
    }
    
    
    var picker: UISegmentedControl = {
        let pk = UISegmentedControl(items: WorkoutPart.allCases.map{ $0.rawValue })
        pk.translatesAutoresizingMaskIntoConstraints = false
        
        return pk
    }()
    
    var addPartButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        
        return btn
    }()
    
    var addPartTextField = CustomTextField(placeholderText: "추가할 운동", height: 30)
    var hLine = CustomHLine()
    var selectedWorkoutList: [UIStackView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        picker.addTarget(self, action: #selector(pickerSelected), for: .valueChanged)
        view.addSubview(picker)

        NSLayoutConstraint.activate([
            picker.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            picker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            picker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
    
    var tempStackView: [UIStackView] = []
    var tempLabel: [UILabel] = []
    var prevBottomAnchor: NSLayoutYAxisAnchor!
    func setRecordField() {
        addPartButton.addTarget(self, action: #selector(addWorkout), for: .touchUpInside)
        view.addSubview(addPartButton)
        view.addSubview(addPartTextField)
        view.addSubview(hLine)
        
        NSLayoutConstraint.activate([
            addPartButton.topAnchor.constraint(equalTo: picker.bottomAnchor, constant: 20),
            addPartButton.trailingAnchor.constraint(equalTo: picker.trailingAnchor),
            
            addPartTextField.topAnchor.constraint(equalTo: addPartButton.topAnchor),
            addPartTextField.leadingAnchor.constraint(equalTo: picker.leadingAnchor),
            addPartTextField.trailingAnchor.constraint(equalTo: addPartButton.leadingAnchor, constant: -20),
            
            hLine.topAnchor.constraint(equalTo: addPartButton.bottomAnchor, constant: 20),
            hLine.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            hLine.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
        
        prevBottomAnchor = hLine.bottomAnchor
        
        let selectedPickerIndex = picker.selectedSegmentIndex
        guard let workoutParts = WorkoutPart(rawValue: WorkoutPart.allCases[selectedPickerIndex].rawValue) else { return }
        
        workoutParts.workoutList.forEach{ part in
            let workListHStack = getWorkListHStack(part: part)
            
            view.addSubview(workListHStack)
            tempStackView.append(workListHStack)
            
            NSLayoutConstraint.activate([
                workListHStack.topAnchor.constraint(equalTo: prevBottomAnchor, constant: 20),
                workListHStack.leadingAnchor.constraint(equalTo: picker.leadingAnchor),
                workListHStack.trailingAnchor.constraint(equalTo: picker.trailingAnchor)
            ])
            prevBottomAnchor = workListHStack.bottomAnchor
        }
        
        let seperator = CustomHLine()
        view.addSubview(seperator)
        
        NSLayoutConstraint.activate([
            seperator.topAnchor.constraint(equalTo: prevBottomAnchor, constant: 20),
            seperator.leadingAnchor.constraint(equalTo: hLine.leadingAnchor),
            seperator.trailingAnchor.constraint(equalTo: hLine.trailingAnchor)
        ])
        
        prevBottomAnchor = seperator.bottomAnchor
    }
    
    func getWorkListHStack(part: String) -> UIStackView {
        let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.distribution = .fill
        hStack.translatesAutoresizingMaskIntoConstraints = false
        
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.numberOfLines = 0
        nameLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
        nameLabel.text = part
        
        let textField = CustomTextField(placeholderText: "세트 입력", height: 30)
        textField.keyboardType = .numberPad
        
        let addButton = UIButton()
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        addButton.tag = tempStackView.count
        addButton.addTarget(self, action: #selector(addSelectedWorkoutList(_:)), for: .touchUpInside)
        
        hStack.addArrangedSubview(nameLabel)
        hStack.addArrangedSubview(textField)
        hStack.addArrangedSubview(addButton)
        
        return hStack
    }
    
    @objc func addSelectedWorkoutList(_ sender: UIButton) {
        let selectedWorkoutHStack: UIStackView = tempStackView[sender.tag]
        var selectedTextField: UITextField? = nil
        var selectedLabel: UILabel? = nil
        
        for element in selectedWorkoutHStack.arrangedSubviews {
            if selectedTextField != nil && selectedLabel != nil {
                break
            }
            if element is UITextField {
                selectedTextField = element as? UITextField
                continue
            } else if element is UILabel {
                selectedLabel = element as? UILabel
                continue
            }
        }
        
        if let tf = selectedTextField, let label = selectedLabel, !tf.text!.isEmpty {
            sender.isEnabled = false
            tf.isEnabled = false
            tf.backgroundColor = .lightGray
            
            let workoutLabel = UILabel()
            workoutLabel.translatesAutoresizingMaskIntoConstraints = false
            workoutLabel.numberOfLines = 2
            workoutLabel.text = label.text!
            
            let setLabel = UILabel()
            setLabel.translatesAutoresizingMaskIntoConstraints = false
            setLabel.text = tf.text! + "세트"
            
            let minusButton = UIButton()
            minusButton.translatesAutoresizingMaskIntoConstraints = false
            minusButton.setImage(UIImage(systemName: "minus.circle"), for: .normal)
            minusButton.addTarget(self, action: #selector(removeSelectedWorkout), for: .touchUpInside)
            
            view.addSubview(workoutLabel)
            view.addSubview(setLabel)
            
            NSLayoutConstraint.activate([
                workoutLabel.topAnchor.constraint(equalTo: prevBottomAnchor, constant: 20),
                workoutLabel.leadingAnchor.constraint(equalTo: selectedWorkoutHStack.leadingAnchor),
                workoutLabel.widthAnchor.constraint(equalToConstant: 120),
                
                setLabel.topAnchor.constraint(equalTo: workoutLabel.topAnchor),
                setLabel.leadingAnchor.constraint(equalTo: workoutLabel.trailingAnchor, constant: 20),
                setLabel.widthAnchor.constraint(equalToConstant: 50)
            ])
            tempLabel.append(workoutLabel)
            prevBottomAnchor = workoutLabel.bottomAnchor
        }
    }
    
    // TODO: -버튼 선택했을 때 선택한 목록 삭제하고 거기에 해당하는 세트입력 TextField, Button isEnable = true로 바꾸기
    @objc func removeSelectedWorkout() {
        
    }
    
    @objc func pickerSelected() {
        addPartTextField.text = ""
        tempStackView.forEach{ $0.removeFromSuperview() }
        tempLabel.forEach{ $0.removeFromSuperview() }
        tempStackView.removeAll()
        tempLabel.removeAll()
        setRecordField()
    }
    
    @objc func addWorkout() {
        let selectedPickerIndex = picker.selectedSegmentIndex
        guard var workoutParts = WorkoutPart(rawValue: WorkoutPart.allCases[selectedPickerIndex].rawValue) else { return }
        guard let newWorkout = addPartTextField.text else { return }
        workoutParts.addWorkoutList(newWorkout)
        tempStackView.forEach{ $0.removeFromSuperview() }
        tempStackView.removeAll()
        setRecordField()
    }
}
