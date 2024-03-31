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
    private let fetchRequest: NSFetchRequest<Record> = Record.fetchRequest()
    
    func getRecordBy(date: String) -> RecordModel? {
        fetchRequest.predicate = NSPredicate(format: "date == %@", date)
        
        var returnRecord: RecordModel?
        do {
            let records = try context.fetch(fetchRequest)
            if let record = records.first {
                let date = record.value(forKey: "date") as! String
                let title = record.value(forKey: "title") as! String
                let content = record.value(forKey: "content") as! String
                let feelingImage = record.value(forKey: "feelingImage") as! String
                returnRecord = RecordModel(date: date, title: title, content: content, feelingImage: feelingImage)
            }
        } catch {
            print("불러오는 중 에러발생 >> \(error)")
        }
        return returnRecord
    }
    
    func editRecord(record: RecordModel) {
        fetchRequest.predicate = NSPredicate(format: "date CONTAINS %@", record.date)
        
        do {
            let records = try context.fetch(fetchRequest)
            if let editRecord = records.first {
                editRecord.title = record.title
                editRecord.content = record.content
                editRecord.feelingImage = record.feelingImage
                
                try context.save()
                print("edit complete!")
            }
        } catch {
            print("수정 중 에러발생 >> \(error)")
        }
    }
}
