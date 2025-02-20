//
//  TodoManagerService.swift
//  ReactorKit_Todo
//
//  Created by MadCow on 2024/11/18.
//

import CoreData

class TodoManagerService {
    static let shared = TodoManagerService()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TodoModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // Todo 저장 메서드
    func saveTodo(_ todo: TodoModel) {
        let todoEntity = TodoModelEntity(context: context)
        todoEntity.title = todo.title
        todoEntity.content = todo.content
        todoEntity.imagePaths = todo.imagePaths
        todoEntity.date = todo.date
//        todoEntity.viewCount = Int32(todo.viewCount)
        
        // Reply 저장
//        for reply in todo.todoReply {
//            let replyEntity = TodoModel(context: context)
//            replyEntity.title = reply.title
//            replyEntity.date = reply.date
//            replyEntity.writer = reply.writer
//            replyEntity.todo = todoEntity
//        }
        
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
    
    // Todo 조회 메서드
    func fetchTodos() -> [TodoModel] {
        let request: NSFetchRequest<TodoModelEntity> = TodoModelEntity.fetchRequest()
        
        do {
            return try context.fetch(request)
        } catch {
            print("Error fetching todos: \(error)")
            return []
        }
    }
}
