import Foundation
import UIKit

// Conforming to UITableViewDelegate and UITableViewDataSource for table view management
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
  
    // Return the number of rows in the table view (equal to the number of tasks)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    // Configure each cell with task data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AppStrings.taskCell, for: indexPath)
        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.title

        
        return cell
    }
    // Handle task selection (navigate to task details when tapped)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = tasks[indexPath.row]
        coordinator.showTaskDetails(task: task)
    }
    
    // Handle swipe-to-delete action on the task cell
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = tasks[indexPath.row]
            viewModel.deleteTask(task: task)
            fetchTasks()
        }
    }
    // Delegate method called when a task is saved
    func didSaveTask() {
        fetchTasks()
        tblList.reloadData()
    }
}
