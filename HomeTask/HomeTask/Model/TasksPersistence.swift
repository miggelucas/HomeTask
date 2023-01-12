//
//  TasksPersistence.swift
//  HomeTask
//
//  Created by Lucas Migge de Barros on 11/01/23.
//

import Foundation
import CoreData


protocol TaskPersistence {
    func fetchTaks(completion: @escaping ([TaskItem]) -> Void)
    
    func saveTask(taskTitle: String, completion: @escaping () -> Void)
    
    func deleteTask(forTask task: TaskItem, completion: @escaping () -> Void)
}


class InMemoryTaskPersistence: TaskPersistence {
    
    private var taskArray: [TaskItem] = []
    
    let container = NSPersistentContainer(name: "TaskItem")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchTaks(completion: @escaping ([TaskItem]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            let fetchRequest: NSFetchRequest<TaskItem> = TaskItem.fetchRequest()
            
            do {
                self.taskArray = try self.container.viewContext.fetch(fetchRequest)
            } catch {
                print("Error fetching data from context \(error)")
            }
            
            completion(self.taskArray)
        }
        
        
    }
    
    func saveTask(taskTitle: String, completion: @escaping () -> Void) {
        let taskContext = TaskItem(context: container.viewContext)
        taskContext.name = taskTitle
        taskContext.id = UUID()
        taskContext.creationDate = Date()
        
        do {
            try container.viewContext.save()
        } catch {
            print("Error saving data to context \(error)")
        }
        completion()
    }
    
    func deleteTask(forTask task: TaskItem, completion: @escaping () -> Void) {
        container.viewContext.delete(task)
        
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch {
                print("Error deleting data from context \(error)")
            }
        }
        completion()
        
    }
}



// apagar depois hihihi
// study later
//    func fetchTaks() async -> [TaskModel] {
//        print("Antes da operação assync - 2")
//
//        let taskArray = [
//            TaskModel(title: "Tirar o lixo"),
//            TaskModel(title: "Lavar a louça"),
//            TaskModel(title: "Botar a roupa na máquina")
//        ]
//
//        print("dentro do assync - 3")
//
//        return taskArray
//    }




