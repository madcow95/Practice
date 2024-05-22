//
//  HomeView.swift
//  Selfit_Clone
//
//  Created by MadCow on 2024/5/20.
//

import UIKit

class RecordView: UIViewController {
    
    private let recordViewModel: RecordViewModel = RecordViewModel()
    
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        
        return scroll
    }()
    
    let contentView: UIView = {
        let content = UIView()
        content.translatesAutoresizingMaskIntoConstraints = false
        
        return content
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setNavigationTitle()
        setNavigationButtons()
        setScrollView()
        // MARK: TODO. 달력 집어넣기(Custom으로 할지 기본 Calendar로 할지..)
    }
    
    func setNavigationTitle() {
        let titleLabel = UILabel()
        titleLabel.text = Date().currentFullDateString(date: Date())
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        titleLabel.textAlignment = .left
        titleLabel.sizeToFit()
        
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        titleLabel.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44)
        titleView.addSubview(titleLabel)

        self.navigationItem.titleView = titleView
    }
    
    // MARK: TODO. 버튼들 색깔 바꾸기
    func setNavigationButtons() {
        let lockButton = UIBarButtonItem(image: UIImage(systemName: "lock"), style: .plain, target: self, action: nil)
        let listButton = UIBarButtonItem(image: UIImage(systemName: "list.bullet.rectangle"), style: .plain, target: self, action: nil)
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(toRecordCreateView))
        
        navigationItem.rightBarButtonItems = [addButton, listButton, lockButton]
    }
    
    func setScrollView() {
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
        
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
    }
    
    @objc func toRecordCreateView() {
        let createView = RecordCreateView()
        navigationController?.pushViewController(createView, animated: true)
    }
}
