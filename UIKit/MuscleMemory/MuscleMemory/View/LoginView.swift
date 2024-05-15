//
//  LoginView.swift
//  MuscleMemory
//
//  Created by MadCow on 2024/5/13.
//

import UIKit
import Combine

class LoginView: UIViewController {
    
    private let idTextField = CustomTextField(placeholderText: "Enter ID")
    private let pwdTextField = CustomTextField(placeholderText: "Enter Password", isSecure: true)
    private let loginButton = CustomButton(buttonColor: .systemBlue, buttonName: "로그인")
    private let joinButton = CustomButton(buttonColor: .systemGray, buttonName: "회원가입")
    private let signHStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.spacing = 20
        
        return stack
    }()
    
    private let loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setViewElements()
        setConstraints()
        setButtonActions()
    }
    
    // MARK: - UI Components Function
    func setViewElements() {
        let allElements = [idTextField, pwdTextField, signHStack]
        allElements.forEach{ view.addSubview($0) }
        
        signHStack.addArrangedSubview(loginButton)
        signHStack.addArrangedSubview(joinButton)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            idTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            idTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            idTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            pwdTextField.topAnchor.constraint(equalTo: idTextField.bottomAnchor, constant: 15),
            pwdTextField.leadingAnchor.constraint(equalTo: idTextField.leadingAnchor),
            pwdTextField.trailingAnchor.constraint(equalTo: idTextField.trailingAnchor),
            
            signHStack.topAnchor.constraint(equalTo: pwdTextField.bottomAnchor, constant: 15),
            signHStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setButtonActions() {
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        joinButton.addTarget(self, action: #selector(join), for: .touchUpInside)
    }
    
    // MARK: - Button Action
    @objc func login() {
//        let navigation = UINavigationController(rootViewController: MuscleMemoryMainView())
        show(MuscleMemoryMainViewDeprecate(), sender: self)
    }
    
    @objc func join() {
        let navigation = UINavigationController(rootViewController: SignView())
        show(navigation, sender: self)
    }
}
