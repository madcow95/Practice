//
//  WeatherMainViewCell.swift
//  Weather_UIKit
//
//  Created by MadCow on 2024/5/29.
//

import UIKit

class WeatherMainViewCell: UITableViewCell {
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    func configureUI(weather: WeatherModel) {
        cityLabel.text = weather.location.name
        self.contentView.addSubview(cityLabel)
        
        NSLayoutConstraint.activate([
            self.cityLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.cityLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
