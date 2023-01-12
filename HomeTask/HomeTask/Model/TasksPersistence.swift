//
//  TasksPersistence.swift
//  HomeTask
//
//  Created by Lucas Migge de Barros on 11/01/23.
//

import Foundation

class TaskPersistence {
    private var taskArray = [
        TaskModel(title: "Tirar o lixo"),
        TaskModel(title: "Lavar a louça"),
        TaskModel(title: "Botar a roupa na máquina")
    ]
    
    func fetchTaks(completion: @escaping ([TaskModel]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion(self.taskArray)
        }
        
    
    }
    
    func saveTask(forTask newTask: TaskModel, completion: @escaping () -> Void) {
        taskArray.append(newTask)
        completion()
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
    
}


