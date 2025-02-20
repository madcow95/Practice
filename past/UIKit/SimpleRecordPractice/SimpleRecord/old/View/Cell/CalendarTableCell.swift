//
//  CalendarTableCell.swift
//  muscleMemory
//
//  Created by MadCow on 2024/2/27.
//

import UIKit

class CalendarTableCell: UICollectionViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var workoutcheckImage: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 10
    }
    
    
}
