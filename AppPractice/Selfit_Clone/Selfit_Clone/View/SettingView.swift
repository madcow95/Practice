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
    
    private let verticalSpacing: CGFloat = 25
    private let horizontalSpacing: CGFloat = 15
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
        setServiceLabels()
        setAppInfoLabels()
        setUserLabels()
    }
    
    func setProfile() {
        let profileHStack = HStack(titleText: "person.crop.circle.fill", contentText: "사용자 이름(비공개)")
        
        contentView.addSubview(profileHStack)
        
        NSLayoutConstraint.activate([
            profileHStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            profileHStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalSpacing),
            profileHStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -horizontalSpacing)
        ])
        
        let hLine = HorizontalLine()
        contentView.addSubview(hLine)
        
        NSLayoutConstraint.activate([
            hLine.topAnchor.constraint(equalTo: profileHStack.bottomAnchor, constant: verticalSpacing),
            hLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalSpacing),
            hLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -horizontalSpacing)
        ])
        prevBottomAnchor = hLine.bottomAnchor
    }
    
    func setSettingLabels() {
        // 언어 설정
        let languageStack = HStack(isSpacingEnable: true, titleText: "언어 (Language)", contentText: Setting.currentLanguage.rawValue)
        
        // 테마 설정
        let themeStack = HStack(isSpacingEnable: true, titleText: "화면 테마", contentText: Setting.currentTheme.rawValue)
        
        // 달력 옵션 설정
        let calendarOptionStack = HStack(isSpacingEnable: true, titleText: "달력 옵션", contentText: Setting.calendarOption.rawValue)
        
        // 운동 완료 설정
        let workoutStack = HStack(isSpacingEnable: true, titleText: "운동 완료", contentText: Setting.workoutComplete.rawValue)
        
        // 구분선
        let hLine = HorizontalLine()
        
        contentView.addSubview(languageStack)
        contentView.addSubview(themeStack)
        contentView.addSubview(calendarOptionStack)
        contentView.addSubview(workoutStack)
        contentView.addSubview(hLine)
        
        NSLayoutConstraint.activate([
            languageStack.topAnchor.constraint(equalTo: prevBottomAnchor, constant: verticalSpacing),
            languageStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalSpacing),
            languageStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -horizontalSpacing),
            
            themeStack.topAnchor.constraint(equalTo: languageStack.bottomAnchor, constant: verticalSpacing),
            themeStack.leadingAnchor.constraint(equalTo: languageStack.leadingAnchor),
            themeStack.trailingAnchor.constraint(equalTo: languageStack.trailingAnchor),
            
            calendarOptionStack.topAnchor.constraint(equalTo: themeStack.bottomAnchor, constant: verticalSpacing),
            calendarOptionStack.leadingAnchor.constraint(equalTo: languageStack.leadingAnchor),
            calendarOptionStack.trailingAnchor.constraint(equalTo: languageStack.trailingAnchor),
            
            workoutStack.topAnchor.constraint(equalTo: calendarOptionStack.bottomAnchor, constant: verticalSpacing),
            workoutStack.leadingAnchor.constraint(equalTo: languageStack.leadingAnchor),
            workoutStack.trailingAnchor.constraint(equalTo: languageStack.trailingAnchor),
            
            hLine.topAnchor.constraint(equalTo: workoutStack.bottomAnchor, constant: verticalSpacing),
            hLine.leadingAnchor.constraint(equalTo: languageStack.leadingAnchor),
            hLine.trailingAnchor.constraint(equalTo: languageStack.trailingAnchor)
        ])
        prevBottomAnchor = hLine.bottomAnchor
    }
    
    func setServiceLabels() {
        // 개인정보 처리방침
        let privateInfoStack = HStack(isSpacingEnable: true, 
                                      titleText: "개인정보 처리방침",
                                      contentText: "chevron.right",
                                      contentIsImage: true,
                                      imageWidth: 15,
                                      imageHeight: 15)
        
        // 서비스 이용약관
        let serviceInfoStack = HStack(isSpacingEnable: true,
                                      titleText: "서비스 이용약관",
                                      contentText: "chevron.right",
                                      contentIsImage: true,
                                      imageWidth: 15,
                                      imageHeight: 15)
        
        // 구분선
        let hLine = HorizontalLine()
        
        contentView.addSubview(privateInfoStack)
        contentView.addSubview(serviceInfoStack)
        contentView.addSubview(hLine)
        
        NSLayoutConstraint.activate([
            privateInfoStack.topAnchor.constraint(equalTo: prevBottomAnchor, constant: verticalSpacing),
            privateInfoStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalSpacing),
            privateInfoStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -horizontalSpacing),
            
            serviceInfoStack.topAnchor.constraint(equalTo: privateInfoStack.bottomAnchor, constant: verticalSpacing),
            serviceInfoStack.leadingAnchor.constraint(equalTo: privateInfoStack.leadingAnchor),
            serviceInfoStack.trailingAnchor.constraint(equalTo: privateInfoStack.trailingAnchor),
            
            hLine.topAnchor.constraint(equalTo: serviceInfoStack.bottomAnchor, constant: verticalSpacing),
            hLine.leadingAnchor.constraint(equalTo: serviceInfoStack.leadingAnchor),
            hLine.trailingAnchor.constraint(equalTo: serviceInfoStack.trailingAnchor)
        ])
        
        prevBottomAnchor = hLine.bottomAnchor
    }
    
    func setAppInfoLabels() {
        // 사용자 리뷰
        let reviewStack = HStack(isSpacingEnable: true, titleText: "사용자 리뷰", contentText: "부탁드려요!")
        
        // 앱 버전
        let versionStack = HStack(isSpacingEnable: true, titleText: "앱 버전", contentText: "3.1.11")
        
        // 구분선
        let hLine = HorizontalLine()
        
        contentView.addSubview(reviewStack)
        contentView.addSubview(versionStack)
        contentView.addSubview(hLine)
        
        NSLayoutConstraint.activate([
            reviewStack.topAnchor.constraint(equalTo: prevBottomAnchor, constant: verticalSpacing),
            reviewStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalSpacing),
            reviewStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -horizontalSpacing),
            
            versionStack.topAnchor.constraint(equalTo: reviewStack.bottomAnchor, constant: verticalSpacing),
            versionStack.leadingAnchor.constraint(equalTo: reviewStack.leadingAnchor),
            versionStack.trailingAnchor.constraint(equalTo: reviewStack.trailingAnchor),
            
            hLine.topAnchor.constraint(equalTo: versionStack.bottomAnchor, constant: verticalSpacing),
            hLine.leadingAnchor.constraint(equalTo: versionStack.leadingAnchor),
            hLine.trailingAnchor.constraint(equalTo: versionStack.trailingAnchor)
        ])
        
        prevBottomAnchor = hLine.bottomAnchor
    }
    
    func setUserLabels() {
        // 로그아웃
        let logoutStack = HStack(isSpacingEnable: true, titleText: "로그아웃", contentText: "chevron.right", contentIsImage: true)
        
        // 앱 버전
        let deleteUserStack = HStack(isSpacingEnable: true, titleText: "계정 삭제", contentText: "chevron.right", contentIsImage: true)
        
        contentView.addSubview(logoutStack)
        contentView.addSubview(deleteUserStack)
        
        NSLayoutConstraint.activate([
            logoutStack.topAnchor.constraint(equalTo: prevBottomAnchor, constant: verticalSpacing),
            logoutStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalSpacing),
            logoutStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -horizontalSpacing),
            
            deleteUserStack.topAnchor.constraint(equalTo: logoutStack.bottomAnchor, constant: verticalSpacing),
            deleteUserStack.leadingAnchor.constraint(equalTo: logoutStack.leadingAnchor),
            deleteUserStack.trailingAnchor.constraint(equalTo: logoutStack.trailingAnchor),
            deleteUserStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
