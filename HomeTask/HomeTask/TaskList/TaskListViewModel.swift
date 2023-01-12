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
    
    private let persistence : TaskPersistence
    
    @Published var tasks: [TaskItem] = []
    @Published var isLoading = true
    @Published var showingAddNewTaskView = false
    @Published var titleNewTask = ""
    @Published var textPlaceholder = "Nome da atividade"
    
    var addTaskViewModel: AddTaskViewModel {
        AddTaskViewModel(persistence: persistence)

    }
    
    init(persistence: TaskPersistence = InMemoryTaskPersistence()) {
        self.persistence = persistence
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
    
    func swipeAction(task: TaskItem) {
        persistence.deleteTask(forTask: task) {
            print("Deletou \(task)")
        }
        fetchData()
    }
    
    func didAppear() {
        fetchData()
    }
    
    func didDismissSheet() {
        isLoading = true
        fetchData()
  
    }
    
    private func fetchData() {
        persistence.fetchTaks { tasksReceived in
            self.tasks = tasksReceived
            self.isLoading = false
        }
    }
    
    
}
