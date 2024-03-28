//
//  RecordHomeView.swift
//  muscleMemory
//
//  Created by MadCow on 2024/3/27.
//

import UIKit

class RecordHomeView: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let recordButton = CustomButton()
    
    let viewModel = RecordHomeViewModel()
    
    var allRecordsDay: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCollectionView()
        setButtons()
        setAllRecords()
    }
    
    func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setButtons() {
        recordButton.setTitle("일기쓰기", for: .normal)
        recordButton.backgroundColor = .systemBlue
        recordButton.addTarget(self, action: #selector(moveToRecordPage), for: .touchUpInside)
        
        view.addSubview(recordButton)
        recordButton.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -20).isActive = true
        recordButton.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor).isActive = true
    }
    
    func setAllRecords() {
        allRecordsDay = viewModel.getTestRecordDay()
    }
    
    @objc func moveToRecordPage() {
        print("touch!")
    }
}

extension RecordHomeView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
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
            cell.recordImage.image = UIImage(systemName: "circle.fill")
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
        let day = indexPath.item
    }
}
