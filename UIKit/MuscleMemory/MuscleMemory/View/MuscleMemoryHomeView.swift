//
//  CalendarViewController.swift
//  MuscleMemory
//
//  Created by MadCow on 2024/5/14.
//

import UIKit

class MuscleMemoryHomeView: UIViewController {

    var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        
        return scroll
    }()
    
    lazy var calendarView: UICalendarView = {
        var view = UICalendarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.wantsDateDecorations = true
        
        return view
    }()
    
    let contentView: UIView = {
        let content = UIView()
        content.translatesAutoresizingMaskIntoConstraints = false
        
        return content
    }()
    
    let hLine = CustomHLine()

    var dummyData: [MuscleMemoryModel] = [
        MuscleMemoryModel(year: 2024, month: 5, day: 1, title: "Title 1", workoutDescription: "Desc 1"),
        MuscleMemoryModel(year: 2024, month: 5, day: 5, title: "Title 2", workoutDescription: "Desc 2"),
        MuscleMemoryModel(year: 2024, month: 5, day: 12, title: "Title 3", workoutDescription: "Desc 3"),
        MuscleMemoryModel(year: 2024, month: 5, day: 21, title: "Title 4", workoutDescription: "Desc 4"),
        MuscleMemoryModel(year: 2024, month: 5, day: 24, title: "Title 5", workoutDescription: "Desc 5"),
        MuscleMemoryModel(year: 2024, month: 5, day: 30, title: "Title 6", workoutDescription: "Desc 6"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setNavigationComponents()
        applyConstraints()
        setCalendar()
        reloadDateView()
    }
    
    func setNavigationComponents() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(toRecordCreateView))
    }
    
    func applyConstraints() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(calendarView)
        contentView.addSubview(hLine)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            calendarView.topAnchor.constraint(equalTo: contentView.topAnchor),
            calendarView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            hLine.topAnchor.constraint(equalTo: calendarView.bottomAnchor),
            hLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            hLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
        
        var beforeConstraint: NSLayoutYAxisAnchor = hLine.bottomAnchor
        dummyData.enumerated().forEach{ (index, workout) in
            let hStack = UIStackView()
            hStack.translatesAutoresizingMaskIntoConstraints = false
            hStack.axis = .horizontal
            hStack.distribution = .equalSpacing
            
            let firstLabel = UILabel()
            firstLabel.translatesAutoresizingMaskIntoConstraints = false
            firstLabel.numberOfLines = 1
            firstLabel.text = workout.title
            
            let secondLabel = UILabel()
            secondLabel.translatesAutoresizingMaskIntoConstraints = false
            secondLabel.numberOfLines = 1
            secondLabel.text = workout.workoutDescription
            
            let thirdLabel = UILabel()
            thirdLabel.translatesAutoresizingMaskIntoConstraints = false
            thirdLabel.numberOfLines = 1
            thirdLabel.text = "\(workout.year)-\(workout.month)-\(workout.day)"
            
            hStack.addArrangedSubview(firstLabel)
            hStack.addArrangedSubview(secondLabel)
            hStack.addArrangedSubview(thirdLabel)
            
            contentView.addSubview(hStack)
            
            hStack.topAnchor.constraint(equalTo: beforeConstraint, constant: 30).isActive = true
            hStack.leadingAnchor.constraint(equalTo: hLine.leadingAnchor).isActive = true
            hStack.trailingAnchor.constraint(equalTo: hLine.trailingAnchor).isActive = true
            
            if index == dummyData.count - 1 {
                hStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
            }
            beforeConstraint = hStack.bottomAnchor
        }
    }
    
    func setCalendar() {
        calendarView.delegate = self
        calendarView.selectionBehavior = UICalendarSelectionSingleDate(delegate: self)
    }
    
    func reloadDateView() {
        calendarView.reloadDecorations(forDateComponents: [], animated: true)
    }
    
    @objc func toRecordCreateView() {
        show(MuscleMemoryCreateView(), sender: self)
    }
}

extension MuscleMemoryHomeView: UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {    
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        if dummyData.filter({ $0.year == dateComponents.year && $0.month == dateComponents.month && $0.day == dateComponents.day }).count > 0 {
            return .customView {
                let image = UIImageView(image: UIImage(systemName: "circle.fill"))
                image.tintColor = .red
                
                return image
            }
        }
        return nil
    }
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        selection.setSelected(dateComponents, animated: true)
//        selectedDate = dateComponents
//        dateArr.append(dateComponents!)
//        reloadDateView()
    }
}
