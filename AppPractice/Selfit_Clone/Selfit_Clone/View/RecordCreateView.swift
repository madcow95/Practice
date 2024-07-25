//
//  RecordCreateView.swift
//  Selfit_Clone
//
//  Created by MadCow on 2024/5/22.
//

import UIKit

class RecordCreateView: UIViewController {
    
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
    
    private var prevBottomAnchor: NSLayoutYAxisAnchor!
    private let verticalSpacing: CGFloat = 15
    private let horizontalSpacing: CGFloat = 15
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setNavigationTitle()
        setScrollView()
        setWorkoutList()
    }
    
    func setNavigationTitle() {
        navigationItem.title = "운동 선택"
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
        prevBottomAnchor = contentView.topAnchor
    }
    
    func setWorkoutList() {
        setChestWorkout()
        setBackWorkout()
        setShoulderWorkout()
        setLegWorkout()
    }
    
    private let imageWidthHeight: CGFloat = 20
    
    func setChestWorkout() {
        let chestLabel = CustomLabel(text: "가슴")
        let hLine = HorizontalLine()
        let chest1HStack = HStack(titleText: "checkmark.circle", contentText: "덤벨 플라이", imageWidth: imageWidthHeight, imageHeight: imageWidthHeight)
        let chest2HStack = HStack(titleText: "checkmark.circle", contentText: "벤치 프레스", imageWidth: imageWidthHeight, imageHeight: imageWidthHeight)
        let chest3HStack = HStack(titleText: "checkmark.circle", contentText: "체스트 프레스", imageWidth: imageWidthHeight, imageHeight: imageWidthHeight)
        
        chest1HStack.isUserInteractionEnabled = true
        
        contentView.addSubview(chestLabel)
        contentView.addSubview(hLine)
        contentView.addSubview(chest1HStack)
        contentView.addSubview(chest2HStack)
        contentView.addSubview(chest3HStack)
        
        NSLayoutConstraint.activate([
            chestLabel.topAnchor.constraint(equalTo: prevBottomAnchor, constant: verticalSpacing),
            chestLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalSpacing),
            chestLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -horizontalSpacing),
            
            hLine.topAnchor.constraint(equalTo: chestLabel.bottomAnchor, constant: verticalSpacing),
            hLine.leadingAnchor.constraint(equalTo: chestLabel.leadingAnchor),
            hLine.trailingAnchor.constraint(equalTo: chestLabel.trailingAnchor),
            
            chest1HStack.topAnchor.constraint(equalTo: hLine.bottomAnchor, constant: verticalSpacing),
            chest1HStack.leadingAnchor.constraint(equalTo: hLine.leadingAnchor),
            chest1HStack.trailingAnchor.constraint(equalTo: hLine.trailingAnchor),
            
            chest2HStack.topAnchor.constraint(equalTo: chest1HStack.bottomAnchor, constant: verticalSpacing),
            chest2HStack.leadingAnchor.constraint(equalTo: chest1HStack.leadingAnchor),
            chest2HStack.trailingAnchor.constraint(equalTo: chest1HStack.trailingAnchor),
            
            chest3HStack.topAnchor.constraint(equalTo: chest2HStack.bottomAnchor, constant: verticalSpacing),
            chest3HStack.leadingAnchor.constraint(equalTo: chest2HStack.leadingAnchor),
            chest3HStack.trailingAnchor.constraint(equalTo: chest2HStack.trailingAnchor),
        ])
        prevBottomAnchor = chest3HStack.bottomAnchor
    }
    
    func setBackWorkout() {
        let backLabel = CustomLabel(text: "등")
        let hLine = HorizontalLine()
        let back1HStack = HStack(titleText: "checkmark.circle", contentText: "덤벨 로우", imageWidth: imageWidthHeight, imageHeight: imageWidthHeight)
        let back2HStack = HStack(titleText: "checkmark.circle", contentText: "데드리프트", imageWidth: imageWidthHeight, imageHeight: imageWidthHeight)
        let back3HStack = HStack(titleText: "checkmark.circle", contentText: "랫 풀다운", imageWidth: imageWidthHeight, imageHeight: imageWidthHeight)
        
        contentView.addSubview(backLabel)
        contentView.addSubview(hLine)
        contentView.addSubview(back1HStack)
        contentView.addSubview(back2HStack)
        contentView.addSubview(back3HStack)
        
        NSLayoutConstraint.activate([
            backLabel.topAnchor.constraint(equalTo: prevBottomAnchor, constant: verticalSpacing * 2),
            backLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalSpacing),
            backLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -horizontalSpacing),
            
            hLine.topAnchor.constraint(equalTo: backLabel.bottomAnchor, constant: verticalSpacing),
            hLine.leadingAnchor.constraint(equalTo: backLabel.leadingAnchor),
            hLine.trailingAnchor.constraint(equalTo: backLabel.trailingAnchor),
            
            back1HStack.topAnchor.constraint(equalTo: hLine.bottomAnchor, constant: verticalSpacing),
            back1HStack.leadingAnchor.constraint(equalTo: hLine.leadingAnchor),
            back1HStack.trailingAnchor.constraint(equalTo: hLine.trailingAnchor),
            
            back2HStack.topAnchor.constraint(equalTo: back1HStack.bottomAnchor, constant: verticalSpacing),
            back2HStack.leadingAnchor.constraint(equalTo: back1HStack.leadingAnchor),
            back2HStack.trailingAnchor.constraint(equalTo: back1HStack.trailingAnchor),
            
            back3HStack.topAnchor.constraint(equalTo: back2HStack.bottomAnchor, constant: verticalSpacing),
            back3HStack.leadingAnchor.constraint(equalTo: back2HStack.leadingAnchor),
            back3HStack.trailingAnchor.constraint(equalTo: back2HStack.trailingAnchor),
        ])
        prevBottomAnchor = back3HStack.bottomAnchor
    }
    
    func setShoulderWorkout() {
        let shoulderLabel = CustomLabel(text: "어깨")
        let hLine = HorizontalLine()
        let shoulder1HStack = HStack(titleText: "checkmark.circle", contentText: "레터럴 레이즈", imageWidth: imageWidthHeight, imageHeight: imageWidthHeight)
        let shoulder2HStack = HStack(titleText: "checkmark.circle", contentText: "숄더 프레스", imageWidth: imageWidthHeight, imageHeight: imageWidthHeight)
        let shoulder3HStack = HStack(titleText: "checkmark.circle", contentText: "프론트 레이즈", imageWidth: imageWidthHeight, imageHeight: imageWidthHeight)
        
        contentView.addSubview(shoulderLabel)
        contentView.addSubview(hLine)
        contentView.addSubview(shoulder1HStack)
        contentView.addSubview(shoulder2HStack)
        contentView.addSubview(shoulder3HStack)
        
        NSLayoutConstraint.activate([
            shoulderLabel.topAnchor.constraint(equalTo: prevBottomAnchor, constant: verticalSpacing * 2),
            shoulderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalSpacing),
            shoulderLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -horizontalSpacing),
            
            hLine.topAnchor.constraint(equalTo: shoulderLabel.bottomAnchor, constant: verticalSpacing),
            hLine.leadingAnchor.constraint(equalTo: shoulderLabel.leadingAnchor),
            hLine.trailingAnchor.constraint(equalTo: shoulderLabel.trailingAnchor),
            
            shoulder1HStack.topAnchor.constraint(equalTo: hLine.bottomAnchor, constant: verticalSpacing),
            shoulder1HStack.leadingAnchor.constraint(equalTo: hLine.leadingAnchor),
            shoulder1HStack.trailingAnchor.constraint(equalTo: hLine.trailingAnchor),
            
            shoulder2HStack.topAnchor.constraint(equalTo: shoulder1HStack.bottomAnchor, constant: verticalSpacing),
            shoulder2HStack.leadingAnchor.constraint(equalTo: shoulder1HStack.leadingAnchor),
            shoulder2HStack.trailingAnchor.constraint(equalTo: shoulder1HStack.trailingAnchor),
            
            shoulder3HStack.topAnchor.constraint(equalTo: shoulder2HStack.bottomAnchor, constant: verticalSpacing),
            shoulder3HStack.leadingAnchor.constraint(equalTo: shoulder2HStack.leadingAnchor),
            shoulder3HStack.trailingAnchor.constraint(equalTo: shoulder2HStack.trailingAnchor),
        ])
        prevBottomAnchor = shoulder3HStack.bottomAnchor
    }
    
    func setLegWorkout() {
        let legLabel = CustomLabel(text: "하체")
        let hLine = HorizontalLine()
        let leg1HStack = HStack(titleText: "checkmark.circle", contentText: "런즈", imageWidth: imageWidthHeight, imageHeight: imageWidthHeight)
        let leg2HStack = HStack(titleText: "checkmark.circle", contentText: "레그 프레스", imageWidth: imageWidthHeight, imageHeight: imageWidthHeight)
        let leg3HStack = HStack(titleText: "checkmark.circle", contentText: "스쿼트", imageWidth: imageWidthHeight, imageHeight: imageWidthHeight)
        let leg4HStack = HStack(titleText: "checkmark.circle", contentText: "레그 익스텐션", imageWidth: imageWidthHeight, imageHeight: imageWidthHeight)
        let leg5HStack = HStack(titleText: "checkmark.circle", contentText: "백 레그 익스텐션", imageWidth: imageWidthHeight, imageHeight: imageWidthHeight)
        
        contentView.addSubview(legLabel)
        contentView.addSubview(hLine)
        contentView.addSubview(leg1HStack)
        contentView.addSubview(leg2HStack)
        contentView.addSubview(leg3HStack)
        contentView.addSubview(leg4HStack)
        contentView.addSubview(leg5HStack)
        
        NSLayoutConstraint.activate([
            legLabel.topAnchor.constraint(equalTo: prevBottomAnchor, constant: verticalSpacing * 2),
            legLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalSpacing),
            legLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -horizontalSpacing),
            
            hLine.topAnchor.constraint(equalTo: legLabel.bottomAnchor, constant: verticalSpacing),
            hLine.leadingAnchor.constraint(equalTo: legLabel.leadingAnchor),
            hLine.trailingAnchor.constraint(equalTo: legLabel.trailingAnchor),
            
            leg1HStack.topAnchor.constraint(equalTo: hLine.bottomAnchor, constant: verticalSpacing),
            leg1HStack.leadingAnchor.constraint(equalTo: hLine.leadingAnchor),
            leg1HStack.trailingAnchor.constraint(equalTo: hLine.trailingAnchor),
            
            leg2HStack.topAnchor.constraint(equalTo: leg1HStack.bottomAnchor, constant: verticalSpacing),
            leg2HStack.leadingAnchor.constraint(equalTo: leg1HStack.leadingAnchor),
            leg2HStack.trailingAnchor.constraint(equalTo: leg1HStack.trailingAnchor),
            
            leg3HStack.topAnchor.constraint(equalTo: leg2HStack.bottomAnchor, constant: verticalSpacing),
            leg3HStack.leadingAnchor.constraint(equalTo: leg2HStack.leadingAnchor),
            leg3HStack.trailingAnchor.constraint(equalTo: leg2HStack.trailingAnchor),
            
            leg4HStack.topAnchor.constraint(equalTo: leg3HStack.bottomAnchor, constant: verticalSpacing),
            leg4HStack.leadingAnchor.constraint(equalTo: leg3HStack.leadingAnchor),
            leg4HStack.trailingAnchor.constraint(equalTo: leg3HStack.trailingAnchor),
            
            leg5HStack.topAnchor.constraint(equalTo: leg4HStack.bottomAnchor, constant: verticalSpacing),
            leg5HStack.leadingAnchor.constraint(equalTo: leg4HStack.leadingAnchor),
            leg5HStack.trailingAnchor.constraint(equalTo: leg4HStack.trailingAnchor),
            leg5HStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        prevBottomAnchor = leg5HStack.bottomAnchor
    }
}
