import Foundation
import CoreData

class CoreDataService {
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "MainStorage")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("DEBUG: Error loading data from CoreData")
            } else {
                print("DEBUG: Successfully loaded data from CoreData")
            }
        }
    }
    
    func fetch<T: NSManagedObject>(_ entityType: T.Type) -> [T]? {
        let request = NSFetchRequest<T>(entityName: String(describing: entityType))
        
        do {
            let fetchedEntities = try container.viewContext.fetch(request)
            return fetchedEntities
        } catch {
            print("DEBUG: Error fetching data with type \(entityType) from CoreData: \(error)")
            return nil
        }
    }
}
