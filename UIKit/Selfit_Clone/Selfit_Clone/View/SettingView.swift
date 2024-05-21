//
//  SettingView.swift
//  Selfit_Clone
//
//  Created by MadCow on 2024/5/20.
//

import UIKit

class SettingView: UIViewController {
    
    private let settingViewModel: SettingViewModel = SettingViewModel()
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        
        return scroll
    }()
    
    private let contentView: UIView = {
        let content = UIView()
        content.translatesAutoresizingMaskIntoConstraints = false
        
        return content
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setNavigationTitle()
        setScrollView()
        setHStacks()
    }
    
    private var prevBottomAnchor: NSLayoutYAxisAnchor!
    
    func setNavigationTitle() {
        let titleLabel = UILabel()
        titleLabel.text = "설정하기"
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        titleLabel.textAlignment = .left
        titleLabel.sizeToFit()
        
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        titleLabel.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44)
        titleView.addSubview(titleLabel)

        self.navigationItem.titleView = titleView
    }
    
    func setScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        prevBottomAnchor = contentView.bottomAnchor
    }
    
    func setHStacks() {
        setProfile()
        setSettingLabels()
    }
    
    func setProfile() {
        let profileHStack = HStack()
        profileHStack.spacing = 15
        
        let profileImage: UIImageView = UIImageView(image: UIImage(systemName: "person.crop.circle.fill"))
        profileImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        profileImage.contentMode = .scaleAspectFit
        profileImage.tintColor = .black
        
        let profileLabel: UILabel = UILabel()
        profileLabel.text = "사용자 이름(비공개)"
        profileLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        profileHStack.addArrangedSubview(profileImage)
        profileHStack.addArrangedSubview(profileLabel)
        
        contentView.addSubview(profileHStack)
        
        NSLayoutConstraint.activate([
            profileHStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            profileHStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            profileHStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
        
        let hLine = HorizontalLine()
        contentView.addSubview(hLine)
        
        NSLayoutConstraint.activate([
            hLine.topAnchor.constraint(equalTo: profileHStack.bottomAnchor, constant: 15),
            hLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            hLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
        prevBottomAnchor = hLine.bottomAnchor
    }
    
    func setSettingLabels() {
        let settingHStack = HStack()
        
    }
}
