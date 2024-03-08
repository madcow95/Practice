//
//  RecordListViewController.swift
//  muscleMemory
//
//  Created by MadCow on 2024/3/7.
//

import UIKit

class RecordListViewController: UIViewController {
    
    var selectedRecordList: [WorkOutRecord] = []
    let viewModel = RecordListViewModel()
    
    @IBOutlet weak var recordListTable: UITableView!
    private let recordTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let recordInfo = viewModel.getRecordName(record: selectedRecordList[0])
        
        recordListTable.delegate = self
        recordListTable.dataSource = self
        recordListTable.layer.borderWidth = 1.0
        recordListTable.layer.cornerRadius = 10
        
        view.addSubview(recordTitle)
        recordTitle.bottomAnchor.constraint(equalTo: recordListTable.topAnchor, constant: -10).isActive = true
        recordTitle.leadingAnchor.constraint(equalTo: recordListTable.leadingAnchor).isActive = true
        recordTitle.text = recordInfo["date"]
        
        view.addSubview(dateLabel)
        dateLabel.bottomAnchor.constraint(equalTo: recordListTable.topAnchor, constant: -10).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: recordTitle.trailingAnchor, constant: 20).isActive = true
        dateLabel.text = recordInfo["name"]
    }
    
}

extension RecordListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return selectedRecordList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecordListViewCell", for: indexPath) as? RecordListViewCell else {
            return UITableViewCell()
        }
        
        let workout = selectedRecordList[indexPath.item]
        let recordInfo = viewModel.getRecordName(record: workout)
        cell.recordNameLabel.text = recordInfo["nameDetail"]
        cell.setLabel.text = "\(workout.set)세트"
        cell.weightLabel.text = "\(workout.weight)kg"
        cell.repsLabel.text = "\(workout.reps)회"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let vc = self.storyboard?.instantiateViewController(identifier: "RecordDetailViewController") as? RecordDetailViewController else { return }
        
        let workout = selectedRecordList[indexPath.item]
        let recordInfo = viewModel.getRecordName(record: workout)
        
        vc.recordName = recordInfo["nameDetail"]!
        vc.set = "\(workout.set)"
        vc.weight = "\(workout.weight)"
        vc.reps = "\(workout.reps)"
        
        self.present(vc, animated: true)
    }
}
