//
//  CustomTextField.swift
//  muscleMemory
//
//  Created by MadCow on 2024/3/3.
//

import UIKit

class CustomTextField: UITextField {
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

class CustomButton: UIButton {
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

class CustomHorizontalStack: UIStackView {
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

class SetRecordHorizontalStack: CustomHorizontalStack {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let setLabel = UILabel()
        setLabel.text = "1세트"
        
        let repsTF = CustomTextField()
        let weightTF = CustomTextField()
        
        repsTF.tag = 1
        weightTF.tag = 2
        
        let plusButton = CustomButton()
        plusButton.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        plusButton.tintColor = .white
        plusButton.backgroundColor = .blue
        
        let minusButton = CustomButton()
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
}

class SaveButtonHorizonStack: CustomHorizontalStack {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let cancelButton = CustomButton()
        cancelButton.backgroundColor = .lightGray
        cancelButton.setTitle("취소", for: .normal)
        
        let saveButton = CustomButton()
        saveButton.backgroundColor = .systemBlue
        saveButton.setTitle("저장", for: .normal)
        
        self.addArrangedSubview(cancelButton)
        self.addArrangedSubview(saveButton)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
