//
//  ContentView.swift
//  API2
//
//  Created by Сергей Богомолов on 04.12.2024.
//

import SwiftUI



struct ToDoListView: View {
  

    @ObservedObject var reload = ReloadView()
    @State var todosModel = [ToDoListModel]()
    @State var presentAlert = false
    @State var str = ""
    var body: some View {
        NavigationView(content: {
            ZStack{
                LinearGradient(colors: [.blue, .purple, .red], startPoint: .topLeading, endPoint: .bottomLeading).ignoresSafeArea()
                VStack {

                    List{
                        
                        ForEach(todosModel) {todo in
                        
                            ToDoRowView(todo: todo, action: {
                                todo.completed = !todo.completed
                            
                                reload.reloadView()
                                
                            })
                        }
                        .onDelete(perform: { indexSet in
                            todosModel.remove(atOffsets: indexSet)
                        })
                    }.scrollContentBackground(.hidden)
                    .padding().onAppear(){
                        Task{
                            do{
                                let toDoList = try await ToDoListAPI.shared.fetchData()
                                self.todosModel = toDoList
                            } catch {
                                throw NetworkingError.dataFailed
                            }
                            
                        }
                    }
                }
            }.navigationTitle("Tasks").toolbar(content: {
                Button("+"){
                    self.presentAlert = true
                }.foregroundColor(.white).padding().font(.title).alert("Add a new task", isPresented: $presentAlert) {
                    TextField("Additing a new task", text: $str).foregroundColor(.black)
                    Button("Cancel", role: .cancel) {
                        str = ""
                    }
                    Button("Ok"){
                        self.todosModel.append(ToDoListModel(userId: 1, id: self.todosModel.count + 1, title: str, completed: false))
                        str = ""
                    }
                }
                
            })
            
           
        })
            

                                                
    }
    
}



#Preview {
    ToDoListView()
        .preferredColorScheme(.dark)
}

class ReloadView: ObservableObject {
    func reloadView() {
        objectWillChange.send()
    }
}




