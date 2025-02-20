//
//  TodoViewCell.swift
//  ReactorKit_Todo
//
//  Created by MadCow on 2024/10/31.
//

import UIKit
import SnapKit

final class TodoViewCell: UITableViewCell {
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialCell()
    }
    
    private func initialCell() {
        contentView.addSubview(label)
        
        label.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
    }
    
    func configureCell(idx: Int) {
        label.text = "\(idx)"
    }
}
