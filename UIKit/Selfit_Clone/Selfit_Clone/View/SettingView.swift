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
        
        view.backgroundColor = .systemBackground
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
        profileLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        
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
            hLine.topAnchor.constraint(equalTo: profileHStack.bottomAnchor, constant: 20),
            hLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            hLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
        prevBottomAnchor = hLine.bottomAnchor
    }
    
    func setSettingLabels() {
        // 언어 설정
        let languageStack = HStack()
        
        let languageLabel = UILabel()
        languageLabel.text = "언어 (Language)"
        languageLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        
        let languageSpacer = UIView()
        languageSpacer.setContentHuggingPriority(.defaultLow, for: .horizontal)
        languageSpacer.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        let settingLanguage = UILabel()
        settingLanguage.text = Setting.currentLanguage.rawValue
        settingLanguage.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        settingLanguage.textColor = .lightGray
        
        languageStack.addArrangedSubview(languageLabel)
        languageStack.addArrangedSubview(languageSpacer)
        languageStack.addArrangedSubview(settingLanguage)
        
        // 테마 설정
        let themeStack = HStack()
        
        let themeLabel = UILabel()
        themeLabel.text = "화면 테마"
        themeLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        
        let themeSpacer = UIView()
        themeSpacer.setContentHuggingPriority(.defaultLow, for: .horizontal)
        themeSpacer.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        let settingTheme = UILabel()
        settingTheme.text = Setting.currentTheme.rawValue
        settingTheme.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        settingTheme.textColor = .lightGray
        
        themeStack.addArrangedSubview(themeLabel)
        themeStack.addArrangedSubview(themeSpacer)
        themeStack.addArrangedSubview(settingTheme)
        
        // 달력 옵션 설정
        let calendarOptionStack = HStack()
        
        let calendarOptionLabel = UILabel()
        calendarOptionLabel.text = "달력 옵션"
        calendarOptionLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        
        let calendarOptionSpacer = UIView()
        calendarOptionSpacer.setContentHuggingPriority(.defaultLow, for: .horizontal)
        calendarOptionSpacer.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        let calendarOption = UILabel()
        calendarOption.text = Setting.calendarOption.rawValue
        calendarOption.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        calendarOption.textColor = .lightGray
        
        calendarOptionStack.addArrangedSubview(calendarOptionLabel)
        calendarOptionStack.addArrangedSubview(calendarOptionSpacer)
        calendarOptionStack.addArrangedSubview(calendarOption)
        
        // 운동 완료 설정
        let workoutStack = HStack()
        
        let workoutLabel = UILabel()
        workoutLabel.text = "운동 완료"
        workoutLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        
        let workoutSpacer = UIView()
        workoutSpacer.setContentHuggingPriority(.defaultLow, for: .horizontal)
        workoutSpacer.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        let workout = UILabel()
        workout.text = Setting.workoutComplete.rawValue
        workout.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        workout.textColor = .lightGray
        
        workoutStack.addArrangedSubview(workoutLabel)
        workoutStack.addArrangedSubview(workoutSpacer)
        workoutStack.addArrangedSubview(workout)
        
        // 구분선
        let hLine = HorizontalLine()
        
        contentView.addSubview(languageStack)
        contentView.addSubview(themeStack)
        contentView.addSubview(calendarOptionStack)
        contentView.addSubview(workoutStack)
        contentView.addSubview(hLine)
        
        NSLayoutConstraint.activate([
            languageStack.topAnchor.constraint(equalTo: prevBottomAnchor, constant: 20),
            languageStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            languageStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            themeStack.topAnchor.constraint(equalTo: languageStack.bottomAnchor, constant: 20),
            themeStack.leadingAnchor.constraint(equalTo: languageStack.leadingAnchor),
            themeStack.trailingAnchor.constraint(equalTo: languageStack.trailingAnchor),
            
            calendarOptionStack.topAnchor.constraint(equalTo: themeStack.bottomAnchor, constant: 20),
            calendarOptionStack.leadingAnchor.constraint(equalTo: languageStack.leadingAnchor),
            calendarOptionStack.trailingAnchor.constraint(equalTo: languageStack.trailingAnchor),
            
            workoutStack.topAnchor.constraint(equalTo: calendarOptionStack.bottomAnchor, constant: 20),
            workoutStack.leadingAnchor.constraint(equalTo: languageStack.leadingAnchor),
            workoutStack.trailingAnchor.constraint(equalTo: languageStack.trailingAnchor),
            
            hLine.topAnchor.constraint(equalTo: workoutStack.bottomAnchor, constant: 20),
            hLine.leadingAnchor.constraint(equalTo: languageStack.leadingAnchor),
            hLine.trailingAnchor.constraint(equalTo: languageStack.trailingAnchor)
        ])
        prevBottomAnchor = hLine.bottomAnchor
    }
}
