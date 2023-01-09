//
//  TaskListViewModel.swift
//  HomeTask
//
//  Created by Lucas Migge de Barros on 30/12/22.
//

import Foundation

class TaskListViewModel: ObservableObject {

    
    enum State {
        case loading, empty, content
    }
    
    @Published var tasks: [TaskModel] = []
    @Published var isLoading = true
    @Published var showingAddNewTaskView = false
    @Published var titleNewTask = ""
    @Published var textPlaceholder = "Nome da atividade"
    
    var state : State {
        if isLoading {
            return .loading
        }
        else if tasks.isEmpty {
            return .empty
        }
        else {
            return .content
        }
    }
    
    func addTaskButtonPressed() {
        showingAddNewTaskView.toggle()
    }
    
    func validateNewTask(forTitle title: String) -> Bool {
        return title.count > 1
        
    }
    
    func confirmPressed() {
        let newTask = TaskModel(title: titleNewTask)
        
        if validateNewTask(forTitle: newTask.title) {
            self.tasks.append(newTask)
            showingAddNewTaskView.toggle()
            titleNewTask = ""
            textPlaceholder = "Nome da atividade"
            
        } else {
            textPlaceholder = "A atividade precisa ter um nome"
            
        }
    }
    
    func didAppear() {
        fetchData()
    }
    
    
    private func fetchData() {
        // simulating fetch remote data
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.tasks = [
                TaskModel(title: "Tirar o lixo"),
                TaskModel(title: "Lavar a louça"),
                TaskModel(title: "Botar a roupa na máquina")
            ]
            
        
            
            self.isLoading = false
        }
        
    }
    
}
