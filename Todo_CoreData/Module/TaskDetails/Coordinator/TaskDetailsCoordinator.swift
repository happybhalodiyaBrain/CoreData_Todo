import UIKit
import CoreData

/// Coordinator responsible for managing the navigation and lifecycle of the Task Details feature.
class TaskDetailsCoordinator {
    
    // MARK: - Properties
    
    /// The navigation controller used to manage view controllers.
    private let navigationController: UINavigationController
    
    /// The Core Data managed object context used for data operations.
    private let context: NSManagedObjectContext
    
    /// The task being viewed or edited
    private let task: Task?
    
    
    // MARK: - Initializer
    
    /// Initializes a new instance of `TaskDetailsCoordinator`.
    /// - Parameters:
    ///   - navigationController: The navigation controller to manage the view hierarchy.
    ///   - context: The Core Data context for data operations.
    ///   - task: The task to be displayed or edited. Default is `nil`.
    init(navigationController: UINavigationController, context: NSManagedObjectContext, task: Task? = nil) {
        self.navigationController = navigationController
        self.context = context
        self.task = task
    }
    
    // MARK: - Methods
    
    /// Starts the Task Details flow by pushing the `TaskDetailViewController` onto
    func start() {
        let taskDetailViewModel = TaskDetailViewModel(context: context, task: task)
        let taskDetailViewController = TaskDetailViewController(viewModel: taskDetailViewModel, coordinator: self)
        navigationController.pushViewController(taskDetailViewController, animated: true)
    }
}
