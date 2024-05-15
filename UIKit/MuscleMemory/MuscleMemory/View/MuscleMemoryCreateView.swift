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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        picker.addTarget(self, action: #selector(pickerSelected), for: .touchUpInside)
        
        view.addSubview(picker)

        NSLayoutConstraint.activate([
            picker.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            picker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            picker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
    
    @objc func pickerSelected() {
        
    }
}
