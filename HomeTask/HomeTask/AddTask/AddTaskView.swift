//
//  AddTaskView.swift
//  HomeTask
//
//  Created by Lucas Migge de Barros on 30/12/22.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var viewModel: AddTaskViewModel

    var body: some View {
        NavigationStack {
            Form {
                Section(viewModel.nameSectionTitle) {
                    TextField(viewModel.textPlaceholder, text: $viewModel.taskTitle)
                    
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.didTapAdd()
                        
                    } label: {
                        Text(viewModel.addButtonTitle)
                        
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        viewModel.didTapCancel()

                    } label: {
                        Text(viewModel.cancelButtonTittle)
                        
                    }
                }
            }
            .onChange(of: viewModel.shouldDismissView) { shouldDismissView in
                if shouldDismissView {
                    dismiss()
                }
                
            }
        }
    }
}


 
struct AddNewTaskView_Previews: PreviewProvider {
    static var persistence = InMemoryTaskPersistence()
    static var viewModel = AddTaskViewModel(persistence: persistence)
    static var previews: some View {
       AddTaskView(viewModel: viewModel) 
    }
}
