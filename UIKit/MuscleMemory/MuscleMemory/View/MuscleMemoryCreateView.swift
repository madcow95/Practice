//
//  MuscleMemoryCreateView.swift
//  MuscleMemory
//
//  Created by MadCow on 2024/5/13.
//

import UIKit

class MuscleMemoryCreateView: UIViewController {
    
    enum WorkoutPart: String, CaseIterable {
        case chest = "가슴"
        case shoulder = "어깨"
        case back = "등"
        case legs = "하체"
        case arms = "팔"
    }
    
    var picker: UISegmentedControl = {
        let pk = UISegmentedControl(items: WorkoutPart.allCases.map{ $0.rawValue })
        pk.translatesAutoresizingMaskIntoConstraints = false
        
        return pk
    }()
    
    var workoutParts: [String] {
        get {
            switch picker.selectedSegmentIndex {
            case 0:
                return ["벤치 프레스", "체스트 프레스", "케이블 프레스", "플라이"]
            case 1:
                return ["밀리터리 프레스", "숄더 프레스", "사이드 레터럴 레이즈"]
            case 2:
                return ["랫 풀 다운", "시티드 로우", "티 바 로우"]
            case 3:
                return ["스쿼트", "레그 익스텐션", "레그 프레스", "런지", "백 레그 익스텐션"]
            case 4:
                return ["이두", "삼두"]
            default:
                return []
            }
        }
    }
    
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
        var prevBottomAnchor = picker.bottomAnchor
        workoutParts.forEach{ part in
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
        tempView.forEach{ $0.removeFromSuperview() }
        setRecordField()
    }
}
