//
//  CustomButton.swift
//  MuscleMemory
//
//  Created by MadCow on 2024/5/13.
//

import UIKit

class CustomButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(buttonColor: UIColor, 
                     buttonName: String,
                     width: CGFloat = 100,
                     height: CGFloat = 50) {
        
        self.init(frame: .zero)
        
        self.backgroundColor = buttonColor
        self.setTitle(buttonName, for: .normal)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
