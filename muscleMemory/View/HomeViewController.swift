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
        collectionView.layer.borderWidth = 1
        collectionView.layer.borderColor = UIColor.black.cgColor
        collectionView.layer.cornerRadius = 10
        
        recordPageButton.addTarget(self, action: #selector(moveToRecordPage), for: .touchUpInside)
        view.addSubview(recordPageButton)
        recordPageButton.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -10).isActive = true
        recordPageButton.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor).isActive = true
        
        view.addSubview(currentMonthLabel)
        currentMonthLabel.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -10).isActive = true
        currentMonthLabel.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor).isActive = true
    }
    
    @objc func moveToRecordPage() {
        // UINavigationController를 사용할 때
        // navigationController?.pushViewController(RecordViewController(), animated: true)
        
        // UIViewController를 사용할 때
        present(RecordViewController(), animated: true)
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
        
        let allWorkoutByMonth = viewModel.getAllTestRecordBy(month: 2)
        let allWorkout = allWorkoutByMonth.map{record in
            let dates = record.totalKey.split(separator: "/")[0]
            let dateData = dates.split(separator: "-")
            let days = dateData[2]
            
            return Int(days)!
        }
        
        cell.dateLabel.text = "\(indexPath.row + 1)"
        if allWorkout.contains(indexPath.row + 1) {
//            print(indexPath.row + 1)
            cell.workoutcheckImage.image = UIImage(systemName: "circle.fill")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 7
        
        return CGSize(width: width, height: width * 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        let allWorkoutByMonth = viewModel.getAllWorkOut()
//
//        print(allWorkoutByMonth[indexPath.item].totalKey)
        
    }
}
