//
//  RecordVIewCell.swift
//  Selfit_Clone
//
//  Created by MadCow on 2024/5/24.
//

import UIKit

class RecordViewCell: UITableViewCell {
    let subCategoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        return label
    }()
    
    let repsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        return label
    }()
    
    let weightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(subCategoryLabel)
        self.addSubview(repsLabel)
        self.addSubview(weightLabel)
        
        NSLayoutConstraint.activate([
            subCategoryLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            subCategoryLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            
            repsLabel.centerYAnchor.constraint(equalTo: subCategoryLabel.centerYAnchor),
            repsLabel.leadingAnchor.constraint(equalTo: subCategoryLabel.trailingAnchor, constant: 20),
            
            weightLabel.centerYAnchor.constraint(equalTo: subCategoryLabel.centerYAnchor),
            weightLabel.leadingAnchor.constraint(equalTo: repsLabel.trailingAnchor, constant: 20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
