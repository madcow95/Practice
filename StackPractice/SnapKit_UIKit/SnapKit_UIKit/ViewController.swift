//
//  ViewController.swift
//  SnapKit_UIKit
//
//  Created by MadCow on 2024/7/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    lazy var testButton1: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("테스트1", for: .normal)
        btn.widthAnchor.constraint(equalToConstant: self.view.frame.width / 3).isActive = true
        btn.heightAnchor.constraint(equalToConstant: self.view.frame.height / 4).isActive = true
        btn.backgroundColor = .black
        btn.setTitleColor(.white, for: .normal)
        
        return btn
    }()
    
    lazy var testButton2: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("테스트2", for: .normal)
        btn.widthAnchor.constraint(equalToConstant: self.view.frame.width / 3).isActive = true
        btn.heightAnchor.constraint(equalToConstant: self.view.frame.height / 4).isActive = true
        btn.backgroundColor = .black
        btn.setTitleColor(.white, for: .normal)
        
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btnArr = [testButton1, testButton2]
        btnArr.forEach{
            self.view.addSubview($0)
            $0.snp.makeConstraints { make in
                make.top.equalTo(self.view.snp.top)
            }
        }
    }
}

