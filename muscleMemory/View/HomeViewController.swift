//
//  ViewController.swift
//  muscleMemory
//
//  Created by MadCow on 2024/2/27.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var calendarTable: UITableView!
    @IBOutlet weak var recordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        calendarTable.dataSource = self
        calendarTable.delegate = self
        
        recordButton.addTarget(self, action: #selector(moveToRecordPage), for: .touchUpInside)
    }
    
    @objc func moveToRecordPage() {
        
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 42
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CalendarTableCell", for: indexPath) as? CalendarTableCell else {
            return UITableViewCell()
        }
        
        cell.testLabel.text = "AAA"
        
        return cell
    }
}
