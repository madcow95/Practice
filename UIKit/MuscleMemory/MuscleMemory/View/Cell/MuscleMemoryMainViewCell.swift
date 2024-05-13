//
//  MuscleMemoryMainViewCell.swift
//  MuscleMemory
//
//  Created by MadCow on 2024/5/13.
//

import UIKit

class MuscleMemoryMainViewCell: UICollectionViewCell {
    var dayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        
        addSubview(dayLabel)
        
        NSLayoutConstraint.activate([
            dayLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            dayLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
