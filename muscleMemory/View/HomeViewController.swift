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
    
    let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        calendarTable.dataSource = self
        calendarTable.delegate = self
        
        recordButton.addTarget(self, action: #selector(moveToRecordPage), for: .touchUpInside)
//         let allWorkouts = viewModel.getAllWorkOut()
    }
    
    @objc func moveToRecordPage() {
        // navigationController?.pushViewController(RecordViewController(), animated: true)
        present(RecordViewController(), animated: true)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getAllWorkOut().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CalendarTableCell", for: indexPath) as? CalendarTableCell else {
            return UITableViewCell()
        }
        
        let allWorkout = viewModel.getAllWorkOut()
        cell.testLabel.text = allWorkout[indexPath.item].name
        
        return cell
    }
}
