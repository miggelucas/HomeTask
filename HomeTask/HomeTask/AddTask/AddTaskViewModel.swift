//
//  AddNewTaskViewModel.swift
//  HomeTask
//
//  Created by Lucas Migge de Barros on 11/01/23.
//

import Foundation

class AddTaskViewModel: ObservableObject {
    let persistence : TaskPersistence
    
    init(persistence: TaskPersistence) {
        self.persistence = persistence
    }
    
    @Published var taskTitle: String = ""
    @Published var textPlaceholder = "Nome da atividade"
    @Published var shouldDismissView = false
    
    @Published var nameSectionTitle = "Nome"
    @Published var addButtonTitle = "Adicionar"
    @Published var cancelButtonTittle = "Cancelar"

    
    func validateNewTask(forTitle title: String) -> Bool {
        return !title.isEmpty
        
    }
    
    func didTapAdd() {

        if validateNewTask(forTitle: taskTitle) {
            persistence.saveTask(taskTitle: taskTitle) {
                print("Salvou")
                self.shouldDismissView.toggle()

            }
        }
    }
    
    func didTapCancel() {
        
    }
    
    
}
