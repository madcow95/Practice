//
//  RecordHomeView.swift
//  muscleMemory
//
//  Created by MadCow on 2024/3/27.
//

import UIKit

class RecordHomeView: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCollectionView()
    }
    
    func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
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
        
        cell.dayLabel.text = "\(indexPath.item + 1)"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 7
        
        return CGSize(width: width, height: width * 1.5)
    }
}
