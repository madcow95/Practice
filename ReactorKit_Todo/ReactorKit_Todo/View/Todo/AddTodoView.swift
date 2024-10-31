//
//  AddTodoView.swift
//  ReactorKit_Todo
//
//  Created by MadCow on 2024/10/31.
//

import SnapKit
import UIKit

class AddTodoView: UIViewController {
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Add Todo", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBrown
        view.addSubview(button)
        
        button.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-100)
        }
    }
}
