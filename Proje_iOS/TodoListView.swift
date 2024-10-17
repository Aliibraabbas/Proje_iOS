import SwiftUI

struct TodoListView: View {
    @State private var todos = [Todo]()
    @State private var newTodo = ""
    @State private var selectedPriority: Priority = .moyenne
    @State private var dueDate = Date()
    @State private var isEditing = false // Variable pour contrôler le mode édition
    @State private var todoToEdit: Todo? // Tâche à éditer
    
    var body: some View {
        NavigationView {
            VStack {
                Text("To-Do List")
                    .font(.largeTitle)
                    .padding(.bottom, 20)

                // Section de création de nouvelles tâches
                HStack {
                    TextField("Nouvelle tâche", text: $newTodo)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    Button(action: addTodo) {
                        Text("Ajouter")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                }

                // Sélection de la priorité
                Picker("Priorité", selection: $selectedPriority) {
                    ForEach(Priority.allCases, id: \.self) { priority in
                        Text(priority.rawValue).tag(priority)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                // Sélection de la date d'échéance
                DatePicker("Date limite", selection: $dueDate, displayedComponents: .date)
                    .padding()

                List {
                    ForEach(todos, id: \.id) { todo in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(todo.title)
                                Text("Échéance: \(todo.dueDate, formatter: taskDateFormatter)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Text(todo.priority.rawValue)
                                .font(.subheadline)
                                .foregroundColor(priorityColor(todo.priority))
                        }
                        .onTapGesture {
                            editTodo(todo) // Quand tu cliques, l'édition commence
                        }
                    }
                    .onDelete(perform: deleteTodo)
                }
            }
            .padding()
            .navigationBarTitle("To-Do List")
            .navigationBarItems(trailing: EditButton()) // Bouton pour activer l'édition
            .sheet(item: $todoToEdit) { todo in
                if let index = todos.firstIndex(of: todo) {
                    EditTodoView(todo: $todos[index])
                }
            }
        }
    }

    // Ajouter une nouvelle tâche
    func addTodo() {
        let newTask = Todo(title: newTodo, priority: selectedPriority, dueDate: dueDate)
        todos.append(newTask)
        newTodo = ""
    }

    // Supprimer une tâche
    func deleteTodo(at offsets: IndexSet) {
        todos.remove(atOffsets: offsets)
    }
    
    // Éditer une tâche
    func editTodo(_ todo: Todo) {
        todoToEdit = todo
    }

    // Couleur en fonction de la priorité
    func priorityColor(_ priority: Priority) -> Color {
        switch priority {
        case .basse:
            return .green
        case .moyenne:
            return .yellow
        case .haute:
            return .red
        }
    }
}

// Vue pour modifier une tâche
struct EditTodoView: View {
    @Binding var todo: Todo
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            TextField("Modifier le titre", text: $todo.title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Picker("Priorité", selection: $todo.priority) {
                ForEach(Priority.allCases, id: \.self) { priority in
                    Text(priority.rawValue).tag(priority)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            DatePicker("Date limite", selection: $todo.dueDate, displayedComponents: .date)
                .padding()

            Button("Enregistrer") {
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
        }
    }
}

struct Todo: Identifiable, Equatable {
    let id = UUID()
    var title: String
    var priority: Priority
    var dueDate: Date
}

enum Priority: String, CaseIterable {
    case basse = "Basse"
    case moyenne = "Moyenne"
    case haute = "Haute"
}

// Formatage de la date
let taskDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter
}()
