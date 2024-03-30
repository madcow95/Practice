//
//  RecordCreateView.swift
//  muscleMemory
//
//  Created by MadCow on 2024/3/28.
//

import UIKit

class RecordCreateView: UIViewController {
    
    private let recordViewModel = RecordCreateViewModel()
    private let homeViewModel = RecordHomeViewModel()
    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var feelingTextField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var recordTextView: UITextView!
    
    private let feelingPicker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setCurrentDate()
        setButtonAction()
    }
    
    func setCurrentDate() {
        let year = homeViewModel.getCurrentYear()
        let month = homeViewModel.getCurrentMonth()
        let day = homeViewModel.getCurrentDay()
        
        dateTextField.text = "\(year)년 \(month)월 \(day)일"
    }
    
    func setButtonAction() {
        cancelButton.addTarget(self, action: #selector(cancelRecord), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveRecord), for: .touchUpInside)
    }
    
    @objc func cancelRecord() {
        dismiss(animated: true)
    }
    
    @objc func saveRecord() {
        
    }
}
