//
//  CustomTextField.swift
//  muscleMemory
//
//  Created by MadCow on 2024/3/3.
//

import UIKit

class CustomTextFieldDeprecated: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 10
        
        let emptyView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = emptyView
        self.leftViewMode = .always
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CustomButtonDeprecated: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 10
        self.widthAnchor.constraint(equalToConstant: 50).isActive = true
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CustomHorizontalStackDeprecated: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.axis = .horizontal
        self.alignment = .fill
        self.distribution = .fillEqually
        self.spacing = 20
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SetRecordHorizontalStackDeprecated: CustomHorizontalStackDeprecated {
    
    let repsTF = CustomTextFieldDeprecated()
    let weightTF = CustomTextFieldDeprecated()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let setLabel = UILabel()
        setLabel.text = "1세트"
        
        let firstStackToolBar = UIToolbar()
        firstStackToolBar.sizeToFit()
        let buttonSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let firstSetTF = UIBarButtonItem(title: "확인", style: .done, target: self, action: #selector(setFirstTextField))
        firstStackToolBar.setItems([buttonSpace, buttonSpace, firstSetTF], animated: true)
        firstStackToolBar.isUserInteractionEnabled = true
        
        repsTF.placeholder = "횟수"
        repsTF.keyboardType = .numberPad
        weightTF.placeholder = "무게"
        weightTF.keyboardType = .numberPad
        
        repsTF.inputAccessoryView = firstStackToolBar
        weightTF.inputAccessoryView = firstStackToolBar
        
        repsTF.tag = 1
        weightTF.tag = 2
        
        let plusButton = CustomButtonDeprecated()
        plusButton.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        plusButton.tintColor = .white
        plusButton.backgroundColor = .blue
        
        let minusButton = CustomButtonDeprecated()
        minusButton.setImage(UIImage(systemName: "minus.circle"), for: .normal)
        minusButton.tintColor = .black
        minusButton.backgroundColor = .white
        
        self.addArrangedSubview(setLabel)
        self.addArrangedSubview(repsTF)
        self.addArrangedSubview(weightTF)
        self.addArrangedSubview(plusButton)
        self.addArrangedSubview(minusButton)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func setFirstTextField() {
        repsTF.resignFirstResponder()
        weightTF.resignFirstResponder()
    }
}

class SaveButtonHorizonStackDeprecated: CustomHorizontalStackDeprecated {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let cancelButton = CustomButtonDeprecated()
        cancelButton.backgroundColor = .lightGray
        cancelButton.setTitle("취소", for: .normal)
        
        let saveButton = CustomButtonDeprecated()
        saveButton.backgroundColor = .systemBlue
        saveButton.setTitle("저장", for: .normal)
        
        self.addArrangedSubview(cancelButton)
        self.addArrangedSubview(saveButton)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
