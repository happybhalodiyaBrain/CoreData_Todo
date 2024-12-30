import CoreData

extension Task {
    static func fetchAllTasks() -> NSFetchRequest<Task> {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "createddate", ascending: false)]
        return request
    }
}
