//
//  ViewController.swift
//  muscleMemory
//
//  Created by MadCow on 2024/2/27.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let recordPageButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("기록하기", for: .normal)
        btn.backgroundColor = .blue
        btn.layer.cornerRadius = 10
        
        return btn
    }()
    
    let currentMonthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        
        let currentDate = Date()
        let calendar = Calendar.current
        let currentMonth = calendar.component(.month, from: currentDate)
        label.text = "\(currentMonth)월"
        
        return label
    }()
    
    let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        collectionView.delegate = self
        collectionView.dataSource = self
        
        recordPageButton.addTarget(self, action: #selector(moveToRecordPage), for: .touchUpInside)
        view.addSubview(recordPageButton)
        recordPageButton.bottomAnchor.constraint(equalTo: collectionView.topAnchor).isActive = true
        recordPageButton.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor).isActive = true
        
        view.addSubview(currentMonthLabel)
        currentMonthLabel.bottomAnchor.constraint(equalTo: collectionView.topAnchor).isActive = true
        currentMonthLabel.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor).isActive = true
    }
    
    @objc func moveToRecordPage() {
        // UINavigationController를 사용할 때
        // navigationController?.pushViewController(RecordViewController(), animated: true)
        
        // UIViewController를 사용할 때
        present(RecordViewController(), animated: true)
        
        guard let randomWorkout = viewModel.getAllWorkOut().randomElement() else {
            return
        }
        let list = viewModel.getWorkOutDetail(mainWorkout: randomWorkout)
        for li in list {
            print(li.name)
        }
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let currentDate = Date()
        let calendar = Calendar.current
        let currentMonth = calendar.component(.month, from: currentDate)

        return viewModel.getDaysBy(month: currentMonth)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarTableCell", for: indexPath) as? CalendarTableCell else {
            return UICollectionViewCell()
        }
        
        let allWorkout = viewModel.getAllTestRecordBy(month: 2)
        
        cell.dateLabel.text = "\(indexPath.row + 1)"
        if allWorkout.contains(indexPath.row + 1) {
            cell.workoutcheckImage.image = UIImage(systemName: "circle.fill")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 7
        
        return CGSize(width: width, height: width * 2)
    }
}

/*
extension HomeViewController: UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 7
        return CGSize(width: width, height: width)
    }
}
*/
