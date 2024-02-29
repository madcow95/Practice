//
//  RecordViewController.swift
//  muscleMemory
//
//  Created by MadCow on 2024/2/29.
//

import UIKit

class RecordViewController: UIViewController {
    
    let testLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "TEST Label"
        label.textColor = .white
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        
        view.addSubview(testLabel)
        testLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        testLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
