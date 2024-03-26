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
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureTable()
        configureLabel()
    }
    
    func configureTable() {
        recordListTable.delegate = self
        recordListTable.dataSource = self
        recordListTable.layer.borderWidth = 1.0
        recordListTable.layer.cornerRadius = 10
    }
    
    func configureLabel() {
        view.addSubview(dateLabel)
        dateLabel.bottomAnchor.constraint(equalTo: recordListTable.topAnchor, constant: -10).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: recordListTable.leadingAnchor, constant: 20).isActive = true
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
        
        guard let workoutName = viewModel.getWorkoutNameBy(key: workout.key) else {
            return UITableViewCell()
        }
        
        guard let workoutDetailname = viewModel.getWorkoutDetailNameBy(key: workout.key, subKey: workout.subKey) else {
            return UITableViewCell()
        }
        
        cell.workoutNameLabel.text = workoutName
        cell.recordNameLabel.text = workoutDetailname
        cell.setLabel.text = "\(workout.set)세트"
        cell.weightLabel.text = "\(workout.weight)kg"
        cell.repsLabel.text = "\(workout.reps)회"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let vc = self.storyboard?.instantiateViewController(identifier: "RecordDetailViewController") as? RecordDetailViewController else { return }
        
        let workout = selectedRecordList[indexPath.item]

        guard let workoutDetailname = viewModel.getWorkoutDetailNameBy(key: workout.key, subKey: workout.subKey) else {
            return
        }
        vc.recordName = workoutDetailname
        vc.set = "\(workout.set)"
        vc.weight = "\(workout.weight)"
        vc.reps = "\(workout.reps)"
        
        self.present(vc, animated: true)
    }
}
