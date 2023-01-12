//
//  AddNewTaskViewModel.swift
//  HomeTask
//
//  Created by Lucas Migge de Barros on 11/01/23.
//

import Foundation

class AddTaskViewModel: ObservableObject {
    let persistence : TaskPersitence
    
    init(persistence: TaskPersitence) {
        self.persistence = persistence
    }
    
    @Published var taskTitle: String = ""
    @Published var textPlaceholder = "Nome da atividade"
    @Published var shouldDismissView = false
    
    @Published var nameSectionTitle = "Nome"
    @Published var addButtonTitle = "Adicionar"
    @Published var cancelButtonTittle = "Cancelar"

    
    func didTapAdd() {
        
        guard !taskTitle.isEmpty else { textPlaceholder =  "A atividade precisa ter um nome"
            return
        }
        
        let newTask = TaskModel(title: taskTitle)
        
        persistence.saveTask(forTask: newTask) {
            print("Salvou")
            self.shouldDismissView.toggle()
            
            
        }
    }
    
    func didTapCancel() {
        
    }
    
    
}
