//
//  AddNewTaskView.swift
//  HomeTask
//
//  Created by Lucas Migge de Barros on 30/12/22.
//

import SwiftUI

struct AddNewTaskView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Binding var taskTitle : String
    @Binding var textPlaceholder : String
    var actionForAdd: () -> Void
    var actionForCancel: () -> Void
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Nome") {
                    TextField(textPlaceholder, text: $taskTitle)
                    
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        actionForAdd()
                        
                    } label: {
                        Text("Adicionar")
                        
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        actionForCancel()
                        dismiss()
                    } label: {
                        Text("Cancelar")
                        
                    }
                }
            }
        }
    }
}



struct AddNewTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewTaskView(taskTitle: .constant(""),
                       textPlaceholder: .constant("Nome da atividade"),
                       actionForAdd: {},
                       actionForCancel: {})
    }
}
