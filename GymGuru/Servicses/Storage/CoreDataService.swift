import Foundation
import CoreData

class CoreDataService {
    
    private var storageName = "MainStorage"
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    
    init() {
        container = NSPersistentContainer(name: storageName)
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("DEBUG: Error loading data from CoreData: \(error)")
            } else {
                print("DEBUG: Successfully loaded data from CoreData")
            }
        }
        context = container.viewContext
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
    
    func save() {
        do {
            try context.save()
            print("DEBUG: Данные успешно сохранены в CoreData")
        }
        catch {
            print("DEBUG: Ошибка сохранения данных в CoreData: \(error)")
        }
    }
}

