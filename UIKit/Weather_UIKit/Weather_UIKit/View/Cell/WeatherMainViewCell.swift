//
//  WeatherMainViewCell.swift
//  Weather_UIKit
//
//  Created by MadCow on 2024/5/29.
//

import UIKit

class WeatherMainViewCell: UITableViewCell {
    
    private let card: UIView = {
        let uv = UIView()
        uv.translatesAutoresizingMaskIntoConstraints = false
        
        return uv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    func configureUI() {
//        self.contentView.heightAnchor.constraint(equalToConstant: self.safeAreaLayoutGuide.layoutFrame.height / 6).isActive = true
//        self.contentView.backgroundColor = .green
    }
    
    func configureCell() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
