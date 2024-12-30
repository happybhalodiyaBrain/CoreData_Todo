import Foundation
import CoreData

/// ViewModel responsible for managing the logic and data operations for Task Details.
class TaskDetailViewModel {
    
    // MARK: - Properties
    /// The Core Data managed object context used for data operations.
    private let context: NSManagedObjectContext
    public let task: Task?
    
    // MARK: - Initializer
    
    /// Initializes a new instance of `TaskDetailViewModel`.
    /// - Parameters:
    ///   - context: The Core Data context for data operations.
    ///   - task: The task to be managed. Can be `nil` for creating a new task.
    init(context: NSManagedObjectContext, task: Task?) {
        self.context = context
        self.task = task
    }
    
    // MARK: - Methods
    
    /// Saves the task with the given title and description. If the task exists, it updates it; otherwise, it creates a new task.
    /// - Parameters:
    ///   - title: The title of the task.
    ///   - description: The description of the task.
    func saveTask(title: String, description: String) {
        if let task = task {
            task.title = title
            task.taskDescription = description
        } else {
            let newTask = Task(context: context)
            newTask.title = title
            newTask.taskDescription = description
            newTask.createddate = Date()
        }
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}
