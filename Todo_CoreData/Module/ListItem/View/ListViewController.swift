import UIKit
import CoreData

// ListViewController handles displaying and managing tasks in a table view
class ListViewController: UIViewController, TaskDetailViewControllerDelegate {
    
    // ViewModel for fetching and managing task data
     let viewModel: TaskViewModel
    
    // Coordinator for navigation between views
     let coordinator: AppCoordinator
    
    // Array to hold tasks
     var tasks: [Task] = []
    
    // Table view for displaying tasks
    private let tableView = UITableView()
    
    // Outlet for table view (if connected via Interface Builder)
    @IBOutlet weak var tblList: UITableView!
    
    // Initializer to inject dependencies (viewModel and coordinator)
    init(viewModel: TaskViewModel, coordinator: AppCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Called when the view is loaded into memory
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchTasks()
        tableView.reloadData()
    }
    
    // Setup UI elements for the view

    private func setupUI() {
        title = AppStrings.tasks
        // Setup table view
        tblList.translatesAutoresizingMaskIntoConstraints = false
        
        tblList.delegate = self
        tblList.dataSource = self
        tblList.register(UITableViewCell.self, forCellReuseIdentifier: AppStrings.taskCell)
        
        // Add "Add" button to the navigation bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask))
    }
    
    // Action method to show task details when the "Add" button is tapped

    @objc func addTask() {
        coordinator.showTaskDetails(task: nil)
        fetchTasks()
        tblList.reloadData()
    }
    
    // Fetch tasks from the view model and reload the table view

    func fetchTasks() {
        DispatchQueue.main.async {
            self.tasks = self.viewModel.fetchTasks()
            self.tblList.reloadData() // Ensure the reload happens on the main thread
        }
    }
}
