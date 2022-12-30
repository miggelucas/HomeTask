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
    
    @Published var tasks: [Task] = []
    @Published var isLoading = true
    
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
    
    func didAppear() {
        fetchData()
    }
    
    
    private func fetchData() {
        // simulating fetch remote data
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.tasks = [
                Task(title: "Tirar o lixo"),
                Task(title: "Lavar a louça"),
                Task(title: "Botar a roupa na máquina")
            ]
            
            self.isLoading = false
        }
        
    }
    
}
