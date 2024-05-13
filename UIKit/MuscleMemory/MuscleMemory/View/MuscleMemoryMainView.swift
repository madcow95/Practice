//
//  MuscleMemoryMainView.swift
//  MuscleMemory
//
//  Created by MadCow on 2024/5/13.
//

import UIKit
import SwiftUI

class MuscleMemoryMainView: UIViewController {
    
    let hostingController = UIHostingController(rootView: CalendarView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hostingController.view)
        
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
