//
//  HStack.swift
//  Selfit_Clone
//
//  Created by MadCow on 2024/5/21.
//

import UIKit

class HStack: UIStackView {
    
    init(frame: CGRect = .zero, 
         isSpacingEnable: Bool = false,
         titleText: String,
         contentText: String,
         contentIsImage: Bool = false) {
        super.init(frame: frame)
        
        self.axis = .horizontal
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let contentLabel = UILabel()
        contentLabel.text = contentText
        contentLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        contentLabel.textColor = .lightGray
        
        if isSpacingEnable {
            let titleLabel = UILabel()
            titleLabel.text = titleText
            titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
            
            let spacer = UIView()
            spacer.setContentHuggingPriority(.defaultLow, for: .horizontal)
            spacer.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
            
            self.addArrangedSubview(titleLabel)
            self.addArrangedSubview(spacer)
            if contentIsImage {
                let contentImage = UIImageView(image: UIImage(systemName: contentText))
                contentImage.widthAnchor.constraint(equalToConstant: 15).isActive = true
                contentImage.heightAnchor.constraint(equalToConstant: 15).isActive = true
                contentImage.contentMode = .scaleAspectFit
                contentImage.tintColor = .lightGray
                
                self.addArrangedSubview(contentImage)
            } else {
                self.addArrangedSubview(contentLabel)
            }
        } else {
            self.spacing = 15
            
            let profileImage: UIImageView = UIImageView(image: UIImage(systemName: titleText))
            profileImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
            profileImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
            profileImage.contentMode = .scaleAspectFit
            profileImage.tintColor = .black
            
            contentLabel.textColor = .black
            
            self.addArrangedSubview(profileImage)
            self.addArrangedSubview(contentLabel)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
