//
//  ToDoRowView.swift
//  API2
//
//  Created by Сергей Богомолов on 04.12.2024.
//

import SwiftUI
import Foundation

struct ToDoRowView: View {
    var todo: ToDoListModel
    var action: () -> ()
    var body: some View {
        HStack{
            todo.completed ? Text(todo.title).strikethrough().foregroundStyle(.gray) : Text(todo.title).foregroundStyle(.black)
            Spacer()
            Button {
                action()
            } label: {
                Image(systemName: todo.completed ? "checkmark.circle" : "circle")
            }
            

        }.padding()
            .background(todo.completed ? .white.opacity(0.5) : .white.opacity(0.8))
            .cornerRadius(10.0)
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
            
        
    }
}

