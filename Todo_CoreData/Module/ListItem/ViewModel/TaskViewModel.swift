import Foundation
import CoreData

/// ViewModel responsible for managing the logic and data operations for the list of tasks.

class TaskViewModel {
    
    // MARK: - Properties
    /// The Core Data managed object context used for data operations.
    private let context: NSManagedObjectContext
    
    // MARK: - Initializer
    
    /// Initializes a new instance of `TaskViewModel`.
    /// - Parameter context: The Core Data context for data operations.
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    // MARK: - Methods
    
    /// Fetches all tasks from the Core Data store.
    /// - Returns: An array of `Task` objects.
    func fetchTasks() -> [Task] {
        return Task.fetchAllTasks(context: context)
        
    }
    
    /// Adds a new task to the Core Data store.
    /// - Parameters:
    ///   - title: The title of the task.
    ///   - description: The description of the task.
    func addTask(title: String, description: String) {
        let newTask = Task(context: context)
        newTask.title = title
        newTask.taskDescription = description
        newTask.createddate = Date()
        saveContext() // Make sure context is saved
    }
    
    /// Edits an existing task.
    /// - Parameters:
    ///   - task: The task to be edited.
    ///   - title: The new title of the task.
    ///   - description: The new description of the task.
    func editTask(task: Task, title: String, description: String) {
        task.title = title
        task.taskDescription = description
        saveContext()
    }
    
    /// Deletes a task from the Core Data store.
    /// - Parameter task: The task to be deleted.
    func deleteTask(task: Task) {
        context.delete(task)
        saveContext()
    }
    
    // MARK: - Private Methods
    
    /// Saves the current state of the Core Data context.
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}
