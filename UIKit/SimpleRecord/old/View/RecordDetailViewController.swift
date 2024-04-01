//
//  RecordDetailViewController.swift
//  muscleMemory
//
//  Created by MadCow on 2024/3/8.
//

import UIKit

class RecordDetailViewController: UIViewController {
    
    var recordName: String = ""
    @IBOutlet weak var recordNameTextField: UITextField!
    var set: String = ""
    @IBOutlet weak var setTextField: UITextField!
    var weight: String = ""
    @IBOutlet weak var weightTextField: UITextField!
    var reps: String = ""
    @IBOutlet weak var repsTextField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    var textFieldEnable: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        recordNameTextField.text = recordName
        setTextField.text = set
        weightTextField.text = weight
        repsTextField.text = reps
        
        recordNameTextField.isEnabled = false
        setTextField.isEnabled = false
        weightTextField.isEnabled = textFieldEnable
        repsTextField.isEnabled = textFieldEnable
        
        saveButton.addTarget(self, action: #selector(changeTextFieldEnable), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(closeModal), for: .touchUpInside)
    }
    
    @objc func changeTextFieldEnable() {
        var btnTitle = "편집"
        if !textFieldEnable {
            btnTitle = "저장"
        }
        textFieldEnable.toggle()
        weightTextField.isEnabled = textFieldEnable
        repsTextField.isEnabled = textFieldEnable
        saveButton.setTitle(btnTitle, for: .normal)
    }
    
    @objc func closeModal() {
        dismiss(animated: true)
    }
}
