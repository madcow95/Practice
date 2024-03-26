//
//  CommonUtil.swift
//  muscleMemory
//
//  Created by MadCow on 2024/3/26.
//

import UIKit
import CoreData

class CommonUtil {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: - TODO: db에 저장하는 공통 함수 만들거임
    func saveData(entity: String) {
        // let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
    }
}
