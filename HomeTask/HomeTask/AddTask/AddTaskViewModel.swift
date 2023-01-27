//
//  AddNewTaskViewModel.swift
//  HomeTask
//
//  Created by Lucas Migge de Barros on 11/01/23.
//

import Foundation

class AddTaskViewModel: ObservableObject {

    private let taskPersistence: TaskPersistence
    
    init(taskPersistence: TaskPersistence = CoreDataTaskPersistence()) {
        self.taskPersistence = taskPersistence
    }
    
    
    @Published var taskTitle: String = ""
    @Published var textPlaceholder = "Nome da atividade"
    @Published var shouldDismissView = false
    
    @Published var nameSectionTitle = "Nome"
    @Published var addButtonTitle = "Adicionar"
    @Published var cancelButtonTittle = "Cancelar"

    
    func isTaskTitleValid(_ title: String) -> Bool {
        if !title.isEmpty && title.count > 3 {
            return true
        } else {
            return false
        }
        
    }
    
    func didTapAdd() {

        if isTaskTitleValid(taskTitle) {
            taskPersistence.saveTask(withTitle: taskTitle) {
                print("Salvou")
                self.shouldDismissView = true

            }
        }
    }
    
    func didTapCancel() {
        shouldDismissView.toggle()
    }
    
    
}
