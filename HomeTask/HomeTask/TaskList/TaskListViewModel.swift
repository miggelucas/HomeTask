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
    
    let coreDataManager = CoreDataManager.shared
    
    @Published var tasks: [TaskItem] = []
    @Published var isLoading = true
    @Published var showingAddNewTaskView = false
    @Published var titleNewTask = ""
    @Published var textPlaceholder = "Nome da atividade"
    
    var addTaskViewModel: AddTaskViewModel {
        AddTaskViewModel()

    }
    
    
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
    
    func didSwipe(on taskItem: TaskItem) {
        coreDataManager.deleteTask(forTask: task) {
        }
        self.loadData()
    }
    
    func didAppear() {
        loadData()
    }
    
    func didDismissSheet() {
        isLoading = true
        loadData()
  
    }
    
    private func loadData() {
        coreDataManager.fetchTaks { tasksReceived in
            self.tasks = tasksReceived
            self.isLoading = false
        }
    }
    
    
}
