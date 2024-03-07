//
//  RecordListViewController.swift
//  muscleMemory
//
//  Created by MadCow on 2024/3/7.
//

import UIKit

class RecordListViewController: UIViewController {
    
    
    private let recordListTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        recordListTable.delegate = self
        recordListTable.dataSource = self
        
        recordListTable.backgroundColor = .red
        view.addSubview(recordListTable)
        recordListTable.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        recordListTable.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

extension RecordListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath) as? RecordListViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
}
