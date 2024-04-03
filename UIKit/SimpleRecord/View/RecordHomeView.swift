//
//  RecordHomeView.swift
//  simpleRecord
//
//  Created by MadCow on 2024/3/27.
//

import UIKit

class RecordHomeView: UIViewController, Reloadable {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let recordButton = CustomButton()
    private let leftButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "arrowtriangle.left.fill"), for: .normal)
        btn.tintColor = .black
        
        return btn
    }()
    private let dateLabel = UILabel()
    private let rightButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "arrowtriangle.right.fill"), for: .normal)
        btn.tintColor = .black
        
        return btn
    }()
    
    let viewModel = RecordHomeViewModel()
    let recordDetailViewModel = RecordDetailViewModel()
    let commonUtil = CommonUtil()
    
    private var allRecords: [RecordModel] = []
    private var allRecordsDay: [Int] = []
    private var selectYear: Int = 0
    private var selectMonth: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        removeAllRecords()
        setCollectionView()
        setUIComponents()
        setDate(year: viewModel.getCurrentYear(), month: viewModel.getCurrentMonth())
        setAllRecords()
        setButtonsAction()
    }
    
    // MARK: - Custom Actions
    func removeAllRecords() {
        viewModel.removeAllRecord()
    }
    
    func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setUIComponents() {
        recordButton.setTitle("일기쓰기", for: .normal)
        recordButton.backgroundColor = .systemBlue
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(recordButton)
        view.addSubview(leftButton)
        view.addSubview(dateLabel)
        view.addSubview(rightButton)
        
        NSLayoutConstraint.activate([
            // 일기쓰기 버튼
            recordButton.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -20),
            recordButton.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            
            // 이전 월로 이동 버튼
            leftButton.leftAnchor.constraint(equalTo: collectionView.leftAnchor),
            leftButton.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -20),
            leftButton.widthAnchor.constraint(equalToConstant: 25),
            leftButton.heightAnchor.constraint(equalToConstant: 25),
            
            // 날짜 표시 Label
            dateLabel.leftAnchor.constraint(equalTo: leftButton.rightAnchor, constant: 10),
            dateLabel.bottomAnchor.constraint(equalTo: leftButton.bottomAnchor, constant: -2),
            
            // 다음 월로 이동 버튼
            rightButton.leftAnchor.constraint(equalTo: dateLabel.rightAnchor, constant: 10),
            rightButton.bottomAnchor.constraint(equalTo: leftButton.bottomAnchor),
            rightButton.widthAnchor.constraint(equalToConstant: 25),
            rightButton.heightAnchor.constraint(equalToConstant: 25),
        ])
    }
    
    func setDate(year: Int, month: Int) {
        selectYear = year
        selectMonth = month
        dateLabel.text = "\(selectYear)년 \(selectMonth)월"
    }
    
    func setAllRecords() {
        allRecords = viewModel.getAllRecord(year: selectYear, month: selectMonth)
        allRecordsDay = viewModel.getRecordsDay(records: allRecords)
    }
    
    func setButtonsAction() {
        recordButton.addTarget(self, action: #selector(moveToRecordPage), for: .touchUpInside)
        leftButton.addTarget(self, action: #selector(toBeforeMonth), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(toNextMonth), for: .touchUpInside)
    }
    
    // MARK: - objc Actrions
    @objc func moveToRecordPage() {
        // Storyboard로 생성한 UIViewController으로 페이지 이동할 때
        let currentDate: String = "\(viewModel.getCurrentYear())-\(viewModel.getCurrentMonth())-\(viewModel.getCurrentDay())"
        let todayRecordExist: Bool = viewModel.todayRecordExist(date: currentDate)
        if todayRecordExist {
            let cancelAction: UIAlertAction = UIAlertAction(title: "취소", style: .cancel)
            let confirmAction: UIAlertAction = UIAlertAction(title: "확인", style: .default) { _ in
                self.openRecordDetailPage(day: nil)
            }
            commonUtil.showAlertBy(buttonActions: [cancelAction, confirmAction],
                                   msg: "오늘 작성한 일기가 있습니다.\n오늘 작성한 일기를 수정할까요?",
                                   mainView: self)
            return
        }
        
        guard let vc = self.storyboard?.instantiateViewController(identifier: "RecordCreateView") as? RecordCreateView else { return }
        vc.customDelegate = self
        present(vc, animated: true)
    }
    
    @objc func toBeforeMonth() {
        if selectMonth <= 1 {
            selectYear -= 1
            selectMonth = 12
        } else {
            selectMonth -= 1
        }
        reloadViewCollection()
    }
    
    @objc func toNextMonth() {
        if selectMonth >= 12 {
            selectYear += 1
            selectMonth = 1
        } else {
            selectMonth += 1
        }
        reloadViewCollection()
    }
    
    private func reloadViewCollection() {
        setDate(year: selectYear, month: selectMonth)
        setAllRecords()
        collectionView.reloadData()
    }
    
    func openRecordDetailPage(day: Int?) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "RecordDetailView") as? RecordDetailView else { return }
        let target = "\(selectYear)-\(selectMonth)-\(day ?? viewModel.getCurrentDay())"
        
        guard let selectedRecord = recordDetailViewModel.getRecordBy(date: target) else {
            return
        }
        vc.selectedRecord = selectedRecord
        vc.customDelegate = self
        
        present(vc, animated: true)
    }
    
    func afterSaveOrEditAction() {
        reloadViewCollection()
    }
}

extension RecordHomeView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getDaysBy(year: selectYear, month: selectMonth)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecordHomeViewCell", for: indexPath) as? RecordHomeViewCell else {
            return UICollectionViewCell()
        }
        
        let calendarDay = indexPath.item + 1
        cell.dayLabel.text = "\(calendarDay)"
        cell.layer.borderWidth = 1.0
        cell.layer.cornerRadius = 10
        
        if allRecordsDay.contains(calendarDay) {
            // MARK: - TODO. ✅
            // 1. Image -> 일기 작성할 때 선택한 기분의 이미지로 수정 ✅ -> 24-04-01
            
            guard let selectedRecord = allRecords.filter({ $0.date == "\(selectYear)-\(selectMonth)-\(calendarDay)" }).first else {
                return UICollectionViewCell()
            }
            
            cell.recordImage.image = UIImage(systemName: String(selectedRecord.feelingImage.split(separator: "/")[1]))
            cell.recordImage.tintColor = .black
        } else {
            cell.recordImage.image = nil
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 7
        
        return CGSize(width: width, height: width * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        openRecordDetailPage(day: indexPath.item + 1)
    }
}
