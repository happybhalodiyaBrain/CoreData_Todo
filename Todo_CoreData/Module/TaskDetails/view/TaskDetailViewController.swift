import UIKit
import IQKeyboardManagerSwift

/// Delegate protocol for `TaskDetailViewController` to notify when a task is saved.
protocol TaskDetailViewControllerDelegate: AnyObject {
    /// Called when the task has been saved.
    func didSaveTask()
}

/// ViewController for displaying and editing task details.
class TaskDetailViewController: UIViewController {
    
    // MARK: - Properties
    /// The ViewModel managing the task's data.
    private let viewModel: TaskDetailViewModel
    
    /// The coordinator managing navigation for the task details flow.
    private let coordinator: TaskDetailsCoordinator
    
    /// The delegate to notify about task-related events.
    weak var delegate: TaskDetailViewControllerDelegate?
    
    //MARK: - Outlets
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtTitleDescription: UITextView!
    @IBOutlet weak var btnSave: UIButton!
    
    //MARK: - Actions
    /// on click save button call this function
    @IBAction func btnSaveTapped(_ sender: UIButton) {
        saveTask()
    }
    
    // MARK: - Initializer
    
    /// Initializes a new instance of `TaskDetailViewController`.
    /// - Parameters:
    ///   - viewModel: The ViewModel for managing task data.
    ///   - coordinator: The coordinator for navigation.
    init(viewModel: TaskDetailViewModel, coordinator: TaskDetailsCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadTaskDetails()
    }
    
    // MARK: - UI Setup
    /// Configures the initial UI setup.
    private func setupUI() {
        view.backgroundColor = .white
        IQKeyboardManager.shared.resignOnTouchOutside = true
        // Set the corner radius to make the edges rounded
        txtTitleDescription.layer.cornerRadius = 10
        txtTitleDescription.layer.masksToBounds = true
        
        // Add a border around the text view
        txtTitleDescription.layer.borderColor = UIColor.lightGray.cgColor
        txtTitleDescription.layer.borderWidth = 1.0
        
        // Add a shadow effect (optional)
        txtTitleDescription.layer.shadowColor = UIColor.black.cgColor
        txtTitleDescription.layer.shadowOffset = CGSize(width: 0, height: 2)
        txtTitleDescription.layer.shadowOpacity = 0.2
        txtTitleDescription.layer.shadowRadius = 4
        
        // Set some padding for the text inside the text view
        txtTitleDescription.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        btnSave.layer.cornerRadius = 5
    }
    
    /// Loads task details into the UI if a task is being edited.
    private func loadTaskDetails() {
        if let task = viewModel.task {
            txtTitle.text = task.title
            txtTitleDescription.text = task.taskDescription
        }
    }
    
    /// Saves the task using the ViewModel and notifies the delegate.
    func saveTask() {
        viewModel.saveTask(title: txtTitle.text ?? "", description: txtTitleDescription.text)
        delegate?.didSaveTask()
        navigationController?.popViewController(animated: true)
        
    }
}
