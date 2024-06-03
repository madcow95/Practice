//
//  TouchableStackView.swift
//  Weather_UIKit
//
//  Created by MadCow on 2024/6/3.
//

import UIKit

class TouchableStackView: UIStackView {    
    var touchEventHandler: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = .vertical
        self.alignment = .center
        self.spacing = 5
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        setTouchEvent()
    }
    
    func setTouchEvent() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tapGesture)
        self.isUserInteractionEnabled = true
    }
    
    @objc private func handleTap() {
        touchEventHandler?()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
