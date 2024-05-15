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
    
    lazy var dateView: UICalendarView = {
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

    var selectedDate: DateComponents? = nil
    var dateArr: [DateComponents] = [DateComponents(year: 2024, month: 5, day: 24),
                                     DateComponents(year: 2024, month: 5, day: 25)]
    
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
        contentView.addSubview(dateView)
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
            
            dateView.topAnchor.constraint(equalTo: contentView.topAnchor),
            dateView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dateView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            hLine.topAnchor.constraint(equalTo: dateView.bottomAnchor),
            hLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            hLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            hLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setCalendar() {
        dateView.delegate = self
        dateView.selectionBehavior = UICalendarSelectionSingleDate(delegate: self)
    }
    
    func reloadDateView() {
        dateView.reloadDecorations(forDateComponents: dateArr, animated: true)
    }
    
    @objc func toRecordCreateView() {
        show(MuscleMemoryCreateView(), sender: self)
    }
}

extension MuscleMemoryHomeView: UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {    
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        if dateArr.filter({ $0.year == dateComponents.year && $0.month == dateComponents.month && $0.day == dateComponents.day }).count > 0 {
            return .customView {
                let image = UIImageView(image: UIImage(systemName: "circle.fill"))
                
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
