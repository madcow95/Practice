//
//  MuscleMemoryMainView.swift
//  MuscleMemory
//
//  Created by MadCow on 2024/5/13.
//

import UIKit
import SwiftUI

class MuscleMemoryMainView: UIViewController {
    
//    let hostingController = UIHostingController(rootView: CalendarView())
    private let divider = CustomHLine()
    private var prevMonthButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "arrowtriangle.left.fill"), for: .normal)
        btn.widthAnchor.constraint(equalToConstant: 40).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btn.contentMode = .scaleAspectFill
        btn.tintColor = .black
        
        return btn
    }()
    
    private var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var nextMonthButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "arrowtriangle.right.fill"), for: .normal)
        btn.widthAnchor.constraint(equalToConstant: 40).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        btn.contentMode = .scaleAspectFill
        btn.tintColor = .black
        
        return btn
    }()
    
    private var daysNameHStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .equalSpacing
        
        return stack
    }()
    
    private var test: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .center
        stack.distribution = .equalSpacing
        
        return stack
    }()
    
    private var date = Date.now
    private let dayStrings: [String] = ["일", "월", "화", "수", "목", "금", "토"]
    private var days: [Date] {
        get {
            return self.date.calendarDisplayDays
        }
        
        set { }
    }
    private var tempStacks: [UIStackView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setNavigationItem()
        setUIComponents()
        setButtonActions()
        setCalendarDays()
    }
    
    func setNavigationItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "",
                                                            image: UIImage(systemName: "plus"),
                                                            target: self,
                                                            action: #selector(toAddPage))
    }
    
    func setUIComponents() {
        let marginGuide = view.layoutMarginsGuide
        [divider, prevMonthButton, dateLabel, nextMonthButton, daysNameHStack].forEach{ view.addSubview($0) }
        dayStrings.forEach{ day in
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = day
            label.font = .systemFont(ofSize: 18, weight: .bold)
            switch day {
            case "토":
                label.textColor = .blue.withAlphaComponent(0.7)
            case "일":
                label.textColor = .red.withAlphaComponent(0.7)
            default:
                label.textColor = .lightGray
            }
            daysNameHStack.addArrangedSubview(label)
        }
        
        NSLayoutConstraint.activate([
            divider.topAnchor.constraint(equalTo: marginGuide.topAnchor),
            divider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            divider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            prevMonthButton.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 10),
            prevMonthButton.leadingAnchor.constraint(equalTo: divider.leadingAnchor),
            
            dateLabel.centerYAnchor.constraint(equalTo: prevMonthButton.centerYAnchor),
            dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nextMonthButton.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 10),
            nextMonthButton.trailingAnchor.constraint(equalTo: divider.trailingAnchor),
            
            daysNameHStack.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 30),
            daysNameHStack.leadingAnchor.constraint(equalTo: prevMonthButton.leadingAnchor, constant: 15),
            daysNameHStack.trailingAnchor.constraint(equalTo: nextMonthButton.trailingAnchor, constant: -15)
        ])
        
        setDateLabelText()
    }
    
    func setButtonActions() {
        prevMonthButton.addTarget(self, action: #selector(toPrevMonth), for: .touchUpInside)
        nextMonthButton.addTarget(self, action: #selector(toNextMonth), for: .touchUpInside)
    }
    
    func setDateLabelText(date: Date = Date.now) {
        self.dateLabel.text = date.currentMonthDateString(date: date)
    }
    
    func setCalendarDays() {
        days = date.calendarDisplayDays
        
        var beforeHStack = daysNameHStack
        var idx = 0
        for _ in 0..<7 {
            var daysHStack = UIStackView()
            daysHStack.axis = .horizontal
            daysHStack.translatesAutoresizingMaskIntoConstraints = false
            daysHStack.alignment = .center
            daysHStack.distribution = .equalCentering
            for index in idx..<idx + 7 {
                var str = ""
                let label = UILabel()
                label.translatesAutoresizingMaskIntoConstraints = false
                label.font = .systemFont(ofSize: 18, weight: .bold)
                label.numberOfLines = 1
                if index < days.count {
                    let day = days[index]
                    if day.monthInt == date.monthInt {
                        str = day.formatted(.dateTime.day())
                    } else {
                        str = day.formatted(.dateTime.day())
                        label.textColor = .lightGray
                    }
                } else {
                    break
                }
                label.text = str
                daysHStack.addArrangedSubview(label)
            }
            if idx >= days.count {
                break
            }
            idx += 7
            view.addSubview(daysHStack)
            
            NSLayoutConstraint.activate([
                daysHStack.topAnchor.constraint(equalTo: beforeHStack.bottomAnchor, constant: 25),
                daysHStack.leadingAnchor.constraint(equalTo: beforeHStack.leadingAnchor),
                daysHStack.trailingAnchor.constraint(equalTo: beforeHStack.trailingAnchor)
            ])
            tempStacks.append(daysHStack)
            beforeHStack = daysHStack
        }
    }
    
    @objc func toAddPage() {
        print("add")
    }
    
    @objc func toPrevMonth() {
        if let prevMonth = Calendar.current.date(byAdding: .month, value: -1, to: date) {
            date = prevMonth
            setDateLabelText(date: date)
            days = date.calendarDisplayDays
            tempStacks.forEach{ $0.removeFromSuperview() }
            setCalendarDays()
        }
    }
    
    @objc func toNextMonth() {
        if let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: date) {
            date = nextMonth
            setDateLabelText(date: date)
            days = date.calendarDisplayDays
            tempStacks.forEach{ $0.removeFromSuperview() }
            setCalendarDays()
        }
    }
}
