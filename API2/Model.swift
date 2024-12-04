//
//  Parsing.swift
//  API2
//
//  Created by Сергей Богомолов on 04.12.2024.
//

import Foundation

class ToDoListModel: Identifiable, Decodable{
    let userId: Int
    let id: Int
    let title: String
    var completed: Bool
    
    init(userId: Int, id: Int, title: String, completed: Bool) {
        self.userId = userId
        self.id = id
        self.title = title
        self.completed = completed
    }
}
