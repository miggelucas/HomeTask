//
//  TaskListView.swift
//  HomeTask
//
//  Created by Lucas Migge de Barros on 30/12/22.
//

import SwiftUI


struct TaskListView: View {
    @ObservedObject var viewModel = TaskListViewModel()
    
    
    var body: some View {
        NavigationStack {
            VStack {
                switch viewModel.state {
                case .loading:
                    VStack (alignment: .center) {
                        ProgressView()
                    }
                    
                case .empty:
                    VStack{
                        Text("Sem Atividades")
                    }
                    
                case .content:
                    List(viewModel.tasks) { task in
                        Text(task.title)
                    }
                    
                }
            }
            
            .sheet(isPresented: $viewModel.showingAddNewTaskView, onDismiss: viewModel.didDismissSheet) {
                AddTaskView(viewModel: viewModel.addTaskViewModel)
            }
            
            .navigationTitle("Atividades")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                viewModel.didAppear()
                
            }
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.addTaskButtonPressed()
                        
                    } label: {
                        Image(systemName: "plus")
                        
                    }
                    
                }
            }
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}
