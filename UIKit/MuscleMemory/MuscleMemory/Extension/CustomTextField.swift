//
//  CustomTextField.swift
//  MuscleMemory
//
//  Created by MadCow on 2024/5/13.
//

import UIKit

class CustomTextField: UITextField {
    
    private let emptySpacing: UIView = {
        let empty = UIView()
        empty.translatesAutoresizingMaskIntoConstraints = false
        empty.widthAnchor.constraint(equalToConstant: 10).isActive = true
        
        return empty
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(placeholderText: String = "",
                     isSecure: Bool = false) {
        self.init(frame: .zero)
        self.placeholder = placeholderText
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leftView = emptySpacing
        self.leftViewMode = .always
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 10
        self.heightAnchor.constraint(equalToConstant: 45).isActive = true
        self.isSecureTextEntry = isSecure
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
