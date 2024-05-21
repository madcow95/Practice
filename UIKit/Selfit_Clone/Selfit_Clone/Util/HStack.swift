//
//  HStack.swift
//  Selfit_Clone
//
//  Created by MadCow on 2024/5/21.
//

import UIKit

class HStack: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.axis = .horizontal
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
