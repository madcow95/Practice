//
//  ViewController.swift
//  Selfit_Clone
//
//  Created by MadCow on 2024/5/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setTabBar()
    }
    
    func setTabBar() {
        let recordView = RecordView()
        recordView.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        
        let dailyView = DailyView()
        dailyView.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
        
        let settingView = SettingView()
        settingView.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 2)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [recordView, dailyView, settingView]
    }
}

