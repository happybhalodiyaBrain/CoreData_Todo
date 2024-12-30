import Foundation
import CoreData

@objc(Task)
public class Task: NSManagedObject {
    @NSManaged public var title: String
    @NSManaged public var taskDescription: String
    @NSManaged public var createddate: Date

}

extension Task {
    static func fetchAllTasks(context: NSManagedObjectContext) -> [Task] {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Error fetching tasks: \(error)")
            return []
        }
    }
}
