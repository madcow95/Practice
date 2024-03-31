//
//  RecordDetailView.swift
//  muscleMemory
//
//  Created by MadCow on 2024/3/30.
//

import UIKit

class RecordDetailView: UIViewController {
    
    private let recordHomeViewModel = RecordHomeViewModel()
    private let recordCreateViewModel = RecordCreateViewModel()
    private let recordDetailViewModel = RecordDetailViewModel()
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var feelingTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    
    private let feelingPicker = UIPickerView()
    private let feelingPickerToolbar = UIToolbar()
    private var feelingImage = UIImageView()
    
    private var editable: Bool = false
    private var feelings: [(String, String)] = []
    private var selectedFeeling: (String, String) = ("", "")
    var selectedRecord: RecordModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setFeelings()
        setFeelingTextField()
        setFeelingPicker()
        setTexts()
        setButtonAction()
    }
    
    func setFeelings() {
        feelings = recordCreateViewModel.getFeelings()
        selectedFeeling = feelings[0]
    }
    
    func setFeelingTextField() {
        contentTextView.layer.cornerRadius = 10
        contentTextView.layer.borderWidth = 1
        
        feelingPicker.delegate = self
        feelingPicker.dataSource = self
        
        feelingTextField.inputView = feelingPicker
    }
    
    func setFeelingPicker() {
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let cancel = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(cancelSelect))
        let confirm = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(confirmSelect))
        
        feelingPickerToolbar.sizeToFit()
        feelingPickerToolbar.setItems([cancel, space, confirm], animated: true)
        feelingPickerToolbar.isUserInteractionEnabled = true
        
        feelingTextField.inputAccessoryView = feelingPickerToolbar
    }
    
    func setTexts() {
        guard let record = selectedRecord else { return }
        titleTextField.text = record.title
        
        let date = record.date.split(separator: "-")
        dateTextField.text = "\(date[0])년 \(date[1])월 \(date[2])일"
        
        let feelingTextString = record.feelingImage.split(separator: "/")
        let feelingText = String(feelingTextString[0])
        let rightViewImage = UIImageView(image: UIImage(systemName: String(feelingTextString[1])))
        rightViewImage.tintColor = .black
        feelingImage.accessibilityIdentifier = String(feelingTextString[1])
        
        feelingTextField.text = feelingText
        feelingTextField.rightView = rightViewImage
        feelingTextField.rightViewMode = .always
        contentTextView.text = record.content
    }
    
    func setButtonAction() {
        cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        editButton.addTarget(self, action: #selector(editAction), for: .touchUpInside)
    }
    
    func editRecord() {
        guard let record = selectedRecord else { return }
        guard let title = titleTextField.text else { return }
        guard let content = contentTextView.text else { return }
        let feeling = feelingTextField.text!
        let imageName = feelingImage.accessibilityIdentifier!
        recordDetailViewModel.editRecord(record: RecordModel(date: record.date, title: title, content: content, feelingImage: "\(feeling)/\(imageName)"))
        
        dismiss(animated: true)
    }
    
    @objc func cancelAction() {
        dismiss(animated: true)
    }
    
    @objc func editAction() {
        // MARK: - TODO. 저장 func로 빼자
        if editable {
            editRecord()
        }
        
        editable.toggle()
        editButton.setTitle(editable ? "저장" : "편집", for: .normal)
        
        let backgroundColor: UIColor = editable ? .white : .systemGray5
        titleTextField.isEnabled = editable
        titleTextField.backgroundColor = backgroundColor
        feelingTextField.isEnabled = editable
        feelingTextField.backgroundColor = backgroundColor
        contentTextView.isEditable = editable
        contentTextView.backgroundColor = backgroundColor
    }
    
    @objc func cancelSelect() {
        feelingTextField.resignFirstResponder()
    }
    
    @objc func confirmSelect() {
        feelingTextField.text = selectedFeeling.0
        
        feelingImage.image = UIImage(systemName: selectedFeeling.1)
        feelingImage.accessibilityIdentifier = selectedFeeling.1
        feelingImage.tintColor = .black
        
        feelingTextField.rightView = feelingImage
        feelingTextField.rightViewMode = .always
        
        feelingTextField.resignFirstResponder()
    }
}


extension RecordDetailView: UIPickerViewDelegate, UIPickerViewDataSource {
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
