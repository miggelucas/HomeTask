//
//  Task.swift
//  HomeTask
//
//  Created by Lucas Migge de Barros on 30/12/22.
//

import Foundation

struct TaskModel: Identifiable {
    let id = UUID()
    let creationDate = Date()
    let title: String
    
}

