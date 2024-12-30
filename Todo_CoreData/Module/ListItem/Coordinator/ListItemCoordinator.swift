import UIKit
import CoreData

/// Coordinator responsible for managing the app's navigation flow.
class AppCoordinator {
    
    // MARK: - Properties
    /// The navigation controller used to manage view controllers.
    private let navigationController: UINavigationController
    /// The Core Data managed object context used for data operations.
    private let context: NSManagedObjectContext
    
    
    // MARK: - Initializer

       /// Initializes a new instance of `AppCoordinator`.
       /// - Parameters:
       ///   - navigationController: The navigation controller to manage the view hierarchy.
       ///   - context: The Core Data context for data operations.
    init(navigationController: UINavigationController, context: NSManagedObjectContext) {
        self.navigationController = navigationController
        self.context = context
    }
    
    // MARK: - Methods

        /// Starts the app's main flow by displaying the task list screen.
    func start() {
        let taskListViewModel = TaskViewModel(context: context)
        let taskListViewController = ListViewController(viewModel: taskListViewModel, coordinator: self)
        navigationController.pushViewController(taskListViewController, animated: true)
    }
    
    /// Displays the task details screen for a specific task.
       /// - Parameter task: The task to be viewed or edited. Pass `nil` to create a new task.
    func showTaskDetails(task: Task?) {
        let taskDetailsCoordinator = TaskDetailsCoordinator(navigationController: navigationController, context: context, task: task)
           taskDetailsCoordinator.start()
           
           // Set the delegate for task details
           if let listVC = navigationController.viewControllers.first(where: { $0 is ListViewController }) as? ListViewController {
               if let taskDetailVC = navigationController.topViewController as? TaskDetailViewController {
                   taskDetailVC.delegate = listVC
               }
           }
    }
}

