//
//  TasksPersistence.swift
//  HomeTask
//
//  Created by Lucas Migge de Barros on 11/01/23.
//

import Foundation
import CoreData


protocol TaskPersistence {
    func fetchTaks(completion: @escaping (Result<[TaskItem], Error>) -> Void)
    
    func saveTask(withTitle taskTitle: String, completion: @escaping () -> Void)
    
    func deleteTask(forTask task: TaskItem, completion: @escaping (Result<[TaskItem], Error>) -> Void)
}


class CoreDataTaskPersistence: TaskPersistence {
    
    static var shared = CoreDataTaskPersistence()
    
    let container: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        container.viewContext
    }
    
    init(container: NSPersistentContainer = NSPersistentContainer(name: "TaskItem")) {
        self.container = container
        self.container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchTaks(completion: @escaping (Result<[TaskItem], Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            let fetchRequest: NSFetchRequest<TaskItem> = TaskItem.fetchRequest()
            var taskArray: [TaskItem] = []
            
            do {
                taskArray = try self.viewContext.fetch(fetchRequest)
            } catch {
                completion(.failure(error))
            }
            
            completion(.success(taskArray))
        }
        
        
    }
    
    func saveTask(withTitle taskTitle: String, completion: @escaping () -> Void) {
        let taskContext = TaskItem(context: container.viewContext)
        taskContext.name = taskTitle
        taskContext.id = UUID()
        taskContext.creationDate = Date()
        
        do {
            try viewContext.save()
        } catch {
            print("Error saving data to context \(error)")
        }
        completion()
    }
    
    func deleteTask(forTask task: TaskItem, completion: @escaping (Result<[TaskItem], Error>) -> Void) {
        viewContext.delete(task)
        
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                // if failed to save changes
                completion(.failure(error))
//                print("Error deleting data from context \(error)")
            }
            
            let fetchRequest: NSFetchRequest<TaskItem> = TaskItem.fetchRequest()
            var taskArray: [TaskItem] = []
            
            do {
                taskArray = try self.viewContext.fetch(fetchRequest)
            } catch {
                completion(.failure(error))
            }
            
            completion(.success(taskArray))
            
            
        }

    }
}





