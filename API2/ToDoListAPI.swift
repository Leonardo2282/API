//
//  NetworkService.swift
//  API2
//
//  Created by Сергей Богомолов on 04.12.2024.
//

import Foundation

class ToDoListAPI{
    static let shared = ToDoListAPI()
    private init() {}
    
    private func createURL() -> URL? {
        let urlStr = "https://jsonplaceholder.typicode.com/users/1/todos"
        let url = URL(string: urlStr)
        return url
        
    }
    
    func fetchData() async throws -> [ToDoListModel]{
        guard let url = createURL() else { throw NetworkingError.badUrl}
        let data = try await URLSession.shared.data(from: url).0
        let decoder = JSONDecoder()
        let toDoList = try decoder.decode([ToDoListModel].self, from: data)
        return toDoList
    }
}

enum NetworkingError: Error{
    case badUrl, dataFailed
}
