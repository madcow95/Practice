//
//  ViewCell.swift
//  CombineTest
//
//  Created by MadCow on 2024/5/8.
//

import UIKit

class ViewCell: UITableViewCell {
    
    let titleTextField: UILabel = {
        let tf = UILabel()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textAlignment = .left
        tf.numberOfLines = 0
        
        return tf
    }()
    
    let thumbnailImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(thumbnailImageView)
        addSubview(titleTextField)
        
        NSLayoutConstraint.activate([
            thumbnailImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            thumbnailImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: 150),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 80),
            
            titleTextField.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 10),
            titleTextField.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleTextField.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
