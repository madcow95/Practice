//
//  MuscleMemoryCreateView.swift
//  MuscleMemory
//
//  Created by MadCow on 2024/5/13.
//

import UIKit

class MuscleMemoryCreateView: UIViewController {
    
    private static var chestPart: [String] = ["벤치 프레스", "체스트 프레스", "케이블 프레스", "플라이"]
    private static var shoulderPart: [String] = ["밀리터리 프레스", "숄더 프레스", "사이드 레터럴 레이즈"]
    private static var backPart: [String] = ["랫 풀 다운", "시티드 로우", "티 바 로우"]
    private static var legsPart: [String] = ["스쿼트", "레그 익스텐션", "레그 프레스", "런지", "백 레그 익스텐션"]
    private static var armsPart: [String] = ["이두", "삼두"]
    
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
                    return chestPart
                case .shoulder:
                    return shoulderPart
                case .back:
                    return backPart
                case .legs:
                    return legsPart
                case .arms:
                    return armsPart
                }
            }
        }
        
        mutating func addWorkoutList(_ newWorkout: String) {
            switch self {
            case .chest:
                MuscleMemoryCreateView.chestPart.append(newWorkout)
            case .shoulder:
                MuscleMemoryCreateView.shoulderPart.append(newWorkout)
            case .back:
                MuscleMemoryCreateView.backPart.append(newWorkout)
            case .legs:
                MuscleMemoryCreateView.legsPart.append(newWorkout)
            case .arms:
                MuscleMemoryCreateView.armsPart.append(newWorkout)
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
    
    var addPartTextField = CustomTextField(placeholderText: "추가할 운동", height: 25)
    var hLine = CustomHLine()
    
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
    
    var tempView: [UIView] = []
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
        
        var prevBottomAnchor = hLine.bottomAnchor
        
        let selectedPickerIndex = picker.selectedSegmentIndex
        guard let workoutParts = WorkoutPart(rawValue: WorkoutPart.allCases[selectedPickerIndex].rawValue) else { return }
        
        workoutParts.workoutList.forEach{ part in
            let hStack = UIStackView()
            hStack.axis = .horizontal
            hStack.distribution = .equalSpacing
            hStack.translatesAutoresizingMaskIntoConstraints = false
            
            let nameLabel = UILabel()
            nameLabel.translatesAutoresizingMaskIntoConstraints = false
            nameLabel.text = part
            
            let textField = UITextField()
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.placeholder = "Enter Here"
            
            let addButton = UIButton()
            addButton.translatesAutoresizingMaskIntoConstraints = false
            addButton.setImage(UIImage(systemName: "plus.circle"), for: .normal)
            
            hStack.addArrangedSubview(nameLabel)
            hStack.addArrangedSubview(textField)
            hStack.addArrangedSubview(addButton)
            
            view.addSubview(hStack)
            tempView.append(hStack)
            
            NSLayoutConstraint.activate([
                hStack.topAnchor.constraint(equalTo: prevBottomAnchor, constant: 20),
                hStack.leadingAnchor.constraint(equalTo: picker.leadingAnchor),
                hStack.trailingAnchor.constraint(equalTo: picker.trailingAnchor)
            ])
            prevBottomAnchor = hStack.bottomAnchor
        }
    }
    
    @objc func pickerSelected() {
        // TODO: 선택한 부위에 따라 저장할 운동 추가
        tempView.forEach{ temp in
            temp.removeFromSuperview()
        }
        tempView.removeAll()
        setRecordField()
    }
    
    @objc func addWorkout() {
        let selectedPickerIndex = picker.selectedSegmentIndex
        guard var workoutParts = WorkoutPart(rawValue: WorkoutPart.allCases[selectedPickerIndex].rawValue) else { return }
        guard let newWorkout = addPartTextField.text else { return }
        workoutParts.addWorkoutList(newWorkout)
        tempView.forEach{ temp in
            temp.removeFromSuperview()
        }
        tempView.removeAll()
        setRecordField()
    }
}
