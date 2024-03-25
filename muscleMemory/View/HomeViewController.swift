//
//  ViewController.swift
//  muscleMemory
//
//  Created by MadCow on 2024/2/27.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let viewModel = HomeViewModel()
    var selectedYear = 0
    var selectedMonth = 0
    var allRecordsDay: [Int] = []
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadRecordDay() // 현재 연, 월에 운동한 날짜 가져오기
        configureCurrentDate() // 현재 날짜를 표시하는 Label에 값 입력
        configureCollectionView() // UICollectionView delegate, dataSource 표시
        configureUI() // UILabel, UIButton등 화면에 배치
    }
    
    func loadRecordDay() {
        allRecordsDay = viewModel.getAllRecordsBySelected(year: selectedYear, month: selectedMonth)
    }
    
    func configureCurrentDate() {
        selectedYear = viewModel.getCurrentYear()
        selectedMonth = viewModel.getCurrentMonth()
    }
    
    func configureCollectionView() {
        // collectionView의 데이터를 표시?
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func configureUI() {
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
        // present(RecordViewController(), animated: true)
        // guard let vc = self.storyboard?.instantiateViewController(identifier: "WorkoutRecordViewController") as? WorkoutRecordViewController else { return }
        present(WorkoutRecordViewController(), animated: true)
    }
    
    @objc func beforeMonth() {
        // MARK: TODO. ViewModel에서 처리하도록 수정
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
        // MARK: TODO. ViewModel에서 처리하도록 수정
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
        // collectionView.reloadData()할 때 연, 월이 바뀌기 때문에 다시 load
        loadRecordDay()
        // UIViewCell의 갯수
        return viewModel.getDaysBy(year: selectedYear, month: selectedMonth)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarTableCell", for: indexPath) as? CalendarTableCell else {
            return UICollectionViewCell()
        }

        cell.dateLabel.text = "\(indexPath.row + 1)"
        // 운동한 날의 유무에 따라 이미지 표시
        cell.workoutcheckImage.image = allRecordsDay.contains(indexPath.row + 1) ? UIImage(systemName: "circle.fill") : nil
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 7
        
        return CGSize(width: width, height: width * 1.5)
    }
    
    // UIViewCell을 선택했을 때 Event -> 여기서는 present로 화면을 띄우는 기능
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedYear = "\(selectedYear)"
        var selectedMonth = "\(selectedMonth)"
        if selectedMonth.count == 1 {
            selectedMonth = "0\(selectedMonth)"
        }
        var selectedDay = "\(indexPath.item + 1)"
        if selectedDay.count == 1 {
            selectedDay = "0\(selectedDay)"
        }
        
        let selectedDate = "\(selectedYear)-\(selectedMonth)-\(selectedDay)"
        let selectedWorkout = viewModel.getSelectedWorkoutBy(date: selectedDate)
        
//        guard let workOuts = selectedWorkout else {
//            return
//        }
        
        // MARK: - TODO: 리팩토링
        let currentMonth = "\(selectedMonth)"
        let month = currentMonth.count == 1 ? "0\(currentMonth)" : "\(currentMonth)"
        
        let selectDate = "\(selectedYear)-\(month)-\(selectedDay.count == 1 ? "0\(selectedDay)" : selectedDay)"
        
        let selectedWorkout2 = viewModel.getTestRecordBy(date: selectDate)
        guard let workOuts = selectedWorkout else {
            return
        }
        if(selectedWorkout2.count > 0) {
            guard let vc = self.storyboard?.instantiateViewController(identifier: "RecordListViewController") as? RecordListViewController else { return }

            vc.selectedRecordList = selectedWorkout2
            present(vc, animated: true)
            
        }
    }
}
