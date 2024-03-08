//
//  RecordListViewController.swift
//  muscleMemory
//
//  Created by MadCow on 2024/3/7.
//

import UIKit

class RecordListViewController: UIViewController {
    
    @IBOutlet weak var recordListTable: UITableView!
    
    /*
     override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = .white
        
        recordListTable.delegate = self
        recordListTable.dataSource = self
    }
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
         view.backgroundColor = .white
         
         recordListTable.delegate = self
         recordListTable.dataSource = self
    }
    
}

extension RecordListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecordListViewCell", for: indexPath) as? RecordListViewCell else {
            return UITableViewCell()
        }
        // print(cell)
         cell.firstLabel.text = "TEST"
        
        return cell
    }
}
