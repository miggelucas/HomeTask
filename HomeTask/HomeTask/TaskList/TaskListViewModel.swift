//
//  TaskListViewModel.swift
//  HomeTask
//
//  Created by Lucas Migge de Barros on 30/12/22.
//

import Foundation

class TaskListViewModel: ObservableObject {
    
    struct TaskView: Identifiable, Equatable {
        let name: String
        let id: UUID
        let creationDate: Date
    }
    
    enum State {
        case loading, empty, content
    }
    
    private let taskPersistence: TaskPersistence
    
    @Published var tasks: [TaskItem] = []
    var taskItemView: [TaskView] {
        self.tasks.map { item in
            return TaskView(name: item.name ?? "Sem nome",
                            id: item.id ?? UUID(),
                            creationDate: item.creationDate ?? Date())
        }
    }
    @Published var isLoading = true
    @Published var showingAddNewTaskView = false
    @Published var titleNewTask = ""
    @Published var textPlaceholder = "Nome da atividade"
    
    
    init(taskPersistence: TaskPersistence = CoreDataTaskPersistence()) {
        self.taskPersistence = taskPersistence
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
        showingAddNewTaskView = true
        
    }
    
    func didSwipe(on task: TaskView) {
        guard let index = taskItemView.firstIndex(of: task) else { return }
        let taskToBeRemoved = tasks[index]
        taskPersistence.deleteTask(forTask: taskToBeRemoved) {
            self.loadData()
        }
    }
    
    func didAppear() {
        loadData()
    }
    
    func didDismissSheet() {
        isLoading = true
        loadData()
        
    }
    
    private func loadData() {
        taskPersistence.fetchTaks { tasksReceived in
            self.tasks = tasksReceived
            self.isLoading = false
        }
    }
    
    
}
