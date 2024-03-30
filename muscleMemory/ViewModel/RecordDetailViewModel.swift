//
//  RecordDetailViewModel.swift
//  muscleMemory
//
//  Created by MadCow on 2024/3/30.
//

import UIKit
import CoreData

class RecordDetailViewModel {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    func editRecord(record: RecordModel) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Record")
        let predicate = NSPredicate(format: "date == %@", record.date)
        fetchRequest.predicate = predicate
        
        if let entity = NSEntityDescription.entity(forEntityName: "Record", in: context) {
            let recordEntity = NSManagedObject(entity: entity, insertInto: context)
            recordEntity.setValue(record.date, forKey: "date")
            recordEntity.setValue(record.title, forKey: "title")
            recordEntity.setValue(record.content, forKey: "content")
            recordEntity.setValue(record.feelingImage, forKey: "feelingImage")
        }
        
        do {
            try context.save()
            print("save complete!")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
