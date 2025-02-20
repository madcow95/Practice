//
//  TodoModelEntity+CoreDataProperties.swift
//  ReactorKit_Todo
//
//  Created by MadCow on 2024/11/18.
//
//

import Foundation
import CoreData


extension TodoModelEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoModelEntity> {
        return NSFetchRequest<TodoModelEntity>(entityName: "TodoModelEntity")
    }

    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var date: Date?
    @NSManaged public var imagePaths: String?

}

extension TodoModelEntity : Identifiable {

}
