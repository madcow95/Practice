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
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var feelingTextField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var recordTextView: UITextView!
    
    private let feelingPicker = UIPickerView()
    private let feelingPickerToolbar = UIToolbar()
    private var feelingImage = UIImageView()
    private var feelings: [(String, String)] = []
    private var selectedFeeling: (String, String) = ("", "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setCurrentDate()
        setButtonAction()
        setFeelingPicker()
        setFeelingPickerToolbar()
        setContent()
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
    
    func setFeelingPicker() {
        feelingPicker.delegate = self
        feelingPicker.dataSource = self
        
        feelingTextField.inputView = feelingPicker
        
        feelingImage.tintColor = .black
        
        feelings = recordViewModel.getFeelings()
        selectedFeeling = feelings[0]
    }
    
    func setContent() {
        recordTextView.layer.cornerRadius = 10
        recordTextView.layer.borderWidth = 1
    }
    
    func setFeelingPickerToolbar() {
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let cancel = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(cancelSelect))
        let confirm = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(confirmSelect))
        
        feelingPickerToolbar.sizeToFit()
        feelingPickerToolbar.setItems([cancel, space, confirm], animated: true)
        feelingPickerToolbar.isUserInteractionEnabled = true
        
        feelingTextField.inputAccessoryView = feelingPickerToolbar
    }
    
    @objc func cancelRecord() {
        dismiss(animated: true)
    }
    
    @objc func saveRecord() {
        let date = "\(homeViewModel.getCurrentYear())-\(homeViewModel.getCurrentMonth())-\(homeViewModel.getCurrentDay())"
        guard let title = titleTextField.text else { return }
        guard let content = recordTextView.text else { return }
        let feeling = feelingTextField.text
        
        recordViewModel.saveRecord(record: RecordModel(date: date, title: title, content: content, feelingImage: feeling))
    }
    
    @objc func cancelSelect() {
        feelingTextField.resignFirstResponder()
    }
    
    @objc func confirmSelect() {
        feelingTextField.text = selectedFeeling.0
        
        feelingImage.image = UIImage(systemName: selectedFeeling.1)
        feelingImage.tintColor = .black
        
        feelingTextField.rightView = feelingImage
        feelingTextField.rightViewMode = .always
        
        feelingTextField.resignFirstResponder()
    }
}

extension RecordCreateView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return feelings.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let feeling = feelings[row]

        return feeling.0
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let feelingView = UIView(frame: CGRect(x: 0, y: 0, width: pickerView.bounds.width, height: 50))
        let feeling = feelings[row]
        
        let feelingLabel = UILabel(frame: CGRect(x: 100, y: 0, width: 100, height: 40))
        feelingLabel.text = feeling.0
        
        let feelingImageView = UIImageView(frame: CGRect(x: 220, y: 0, width: 50, height: 50))
        feelingImageView.image = UIImage(systemName: feelings[row].1)
        feelingImageView.tintColor = .black
        
        feelingView.addSubview(feelingLabel)
        feelingView.addSubview(feelingImageView)
        
        return feelingView
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedFeeling = feelings[row]
    }
}
