//
//  ViewController.swift
//  muscleMemory
//
//  Created by MadCow on 2024/2/27.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let viewModel = HomeViewModel()
    
    // 달력 형식을 표시할 collectionView
    @IBOutlet weak var collectionView: UICollectionView!
    
    // 기록하기 페이지로 이동할 Button
    let recordPageButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("기록하기", for: .normal)
        btn.backgroundColor = .blue
        btn.layer.cornerRadius = 10
        btn.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        return btn
    }()
    
    // 이전 월로 이동하는 Button
    let leftButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "arrowtriangle.left.fill"), for: .normal)
        btn.tintColor = .black
        
        return btn
    }()
    
    // 현재 월을 나타내는 Label
    let currentMonthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        
        return label
    }()
    
    // 다음 월로 이동하는 Button
    let rightButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "arrowtriangle.right.fill"), for: .normal)
        btn.tintColor = .black
        
        return btn
    }()
    
    var selectedYear = 0
    var selectedMonth = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentDate = viewModel.getCurrentDate()
        selectedMonth = Int(currentDate["month"]!)!
        selectedYear = Int(currentDate["year"]!)!
        
        // collectionView의 데이터를 표시?
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // 기록하기 페이지 Button에 대한 정보
        recordPageButton.addTarget(self, action: #selector(moveToRecordPage), for: .touchUpInside)
        view.addSubview(recordPageButton)
        recordPageButton.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -10).isActive = true
        recordPageButton.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor).isActive = true
        
        // 이전 월로 이동하기 Button에 대한 정보
        leftButton.addTarget(self, action: #selector(beforeMonth), for: .touchUpInside)
        view.addSubview(leftButton)
        leftButton.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor).isActive = true
        // leftButton.trailingAnchor.constraint(equalTo: currentMonthLabel.leadingAnchor, constant: -5).isActive = true
        leftButton.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -10).isActive = true
        
        // 현재 월을 나타내는 Label에 대한 정보
        currentMonthLabel.text = "\(selectedYear)년 \(selectedMonth)월"
        view.addSubview(currentMonthLabel)
        currentMonthLabel.bottomAnchor.constraint(equalTo: leftButton.bottomAnchor).isActive = true
        currentMonthLabel.leadingAnchor.constraint(equalTo: leftButton.trailingAnchor, constant: 5).isActive = true
        
        // 다음 월로 이동하기 Button에 대한 정보
        rightButton.addTarget(self, action: #selector(nextMonth), for: .touchUpInside)
        view.addSubview(rightButton)
        rightButton.leadingAnchor.constraint(equalTo: currentMonthLabel.trailingAnchor, constant: 5).isActive = true
        rightButton.bottomAnchor.constraint(equalTo: currentMonthLabel.bottomAnchor).isActive = true
    }
    
    @objc func moveToRecordPage() {
        // UINavigationController으로 페이지 이동할 때
        // navigationController?.pushViewController(RecordViewController(), animated: true)
        
        // UIViewController으로 페이지 이동할 때
        present(RecordViewController(), animated: true)
    }
    
    @objc func beforeMonth() {
        
        if selectedMonth > 1 {
            selectedMonth -= 1
        } else {
            selectedYear -= 1
            selectedMonth = 12
        }
        currentMonthLabel.text = "\(selectedYear)년 \(selectedMonth)월"
        collectionView.reloadData()
    }
    
    @objc func nextMonth() {
        
        if selectedMonth < 12 {
            selectedMonth += 1
        } else {
            selectedYear += 1
            selectedMonth = 1
        }
        currentMonthLabel.text = "\(selectedYear)년 \(selectedMonth)월"
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // dictionary형식 ["year": "YYYY", "month": "mm", "day": "dd"]으로 return됨
        // let currentDate = viewModel.getCurrentDate()

        return viewModel.getDaysBy(month: selectedMonth)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarTableCell", for: indexPath) as? CalendarTableCell else {
            return UICollectionViewCell()
        }
        
        let allWorkoutByMonth = viewModel.getAllTestRecordBy(year: selectedYear, month: selectedMonth)
        let allWorkout = allWorkoutByMonth.map{record in
            let dates = record.totalKey.split(separator: "/")[0]
            let dateData = dates.split(separator: "-")
            let days = dateData[2]
            
            return Int(days)!
        }

        cell.dateLabel.text = "\(indexPath.row + 1)"
        if allWorkout.count > 0 && allWorkout.contains(indexPath.row + 1) {
            cell.workoutcheckImage.image = UIImage(systemName: "circle.fill")
        } else {
            cell.workoutcheckImage.image = nil
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 7
        
        return CGSize(width: width, height: width * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let currentMonth = "\(selectedMonth)"
        let month = currentMonth.count == 1 ? "0\(currentMonth)" : "\(currentMonth)"
        
        let selectedDay = "\(indexPath.item + 1)"
        let selectDate = "\(selectedYear)-\(month)-\(selectedDay.count == 1 ? "0\(selectedDay)" : selectedDay)"
        
        let selectedWorkout = viewModel.getTestRecordBy(date: selectDate)
        if(selectedWorkout.count > 0) {
            present(RecordListViewController(), animated: true)
        }
    }
}
