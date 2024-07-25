//
//  MuscleMemoryView.swift
//  MuscleMemory
//
//  Created by MadCow on 2024/5/15.
//

import UIKit

class MuscleMemoryView: UIViewController {
    
    private let collectionView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        collectionView.register(CalendarViewCell.self, forCellReuseIdentifier: "CalendarViewCell")
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension MuscleMemoryView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableCell = tableView.dequeueReusableCell(withIdentifier: "CalendarViewCell", for: indexPath) as? CalendarViewCell else {
            return UITableViewCell()
        }
        
//        guard let recordListCell = tableView.dequeueReusableCell(withIdentifier: "RecordListViewCell", for: indexPath) as? RecordListViewCell else {
//            return UITableViewCell()
//        }
        
//        switch indexPath.row {
//        case 0:
//            return tableCell
//        default:
//            return recordListCell
//        }
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
}
