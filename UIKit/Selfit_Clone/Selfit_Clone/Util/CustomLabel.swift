//
//  CustomLabel.swift
//  Selfit_Clone
//
//  Created by MadCow on 2024/5/22.
//

import UIKit

class CustomLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    convenience init(
        text: String,
        textColor: UIColor? = nil
    ) {
        self.init(frame: .zero)
        self.text = text
        self.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        if let color = textColor {
            self.textColor = color
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
