//
//  TasksPersistence.swift
//  HomeTask
//
//  Created by Lucas Migge de Barros on 11/01/23.
//

import Foundation
import CoreData


protocol TaskPersistence {
    func fetchTasks(completion: @escaping ([TaskItem]) -> Void)
    
    func saveTask(withTitle taskTitle: String, completion: @escaping () -> Void)
    
    func delete(task: TaskItem, completion: @escaping () -> Void)
}


class CoreDataTaskPersistence: TaskPersistence {
    
    static var shared = CoreDataManager()
    
    let container: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        container.viewContext
    }
    
   
    init() {
        container = NSPersistentContainer(name: "TaskItem")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchTaks(completion: @escaping ([TaskItem]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            let fetchRequest: NSFetchRequest<TaskItem> = TaskItem.fetchRequest()
            var taskArray: [TaskItem] = []
            
            do {
                taskArray = try self.viewContext.fetch(fetchRequest)
            } catch {
                print("Error fetching data from context \(error)")
            }
            
            completion(taskArray)
        }
        
        
    }
    
    func saveTask(taskTitle: String, completion: @escaping () -> Void) {
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
    
    func deleteTask(forTask task: TaskItem, completion: @escaping () -> Void) {
        viewContext.delete(task)
        
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                print("Error deleting data from context \(error)")
            }
        }
        completion()
        
    }
}





