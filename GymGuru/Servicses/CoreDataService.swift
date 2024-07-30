//import Foundation
//import CoreData
//
//class CoreDataService {
//    
//    let container: NSPersistentContainer
//    
//    init() {
//        container = NSPersistentContainer(name: "MainStorage")
//        container.loadPersistentStores { (description, error) in
//            if let error = error {
//                print("DEBUG: Error loading data from CoreData: \(error)")
//            } else {
//                print("DEBUG: Successfully loaded data from CoreData")
//            }
//        }
//    }
//    
//    func fecthExerciseTypes() throws -> [ExerciseType] {
//        guard let exerciseTypeEntities = fetch(ExerciseTypeEntity.self) else {
//            throw CoreDaraErrors.fecthFailed
//        }
//        
//        var exerciseTypes = [ExerciseType]()
//        
//        for entity in exerciseTypeEntities {
//            let exerciseType = try convertEntityToExerciseType(entity)
//            exerciseTypes.append(exerciseType)
//        }
//        
//        return exerciseTypes
//    }
//    
//    func fetch<T: NSManagedObject>(_ entityType: T.Type) -> [T]? {
//        let request = NSFetchRequest<T>(entityName: String(describing: entityType))
//        
//        do {
//            let fetchedEntities = try container.viewContext.fetch(request)
//            return fetchedEntities
//        } catch {
//            print("DEBUG: Error fetching data with type \(entityType) from CoreData: \(error)")
//            return nil
//        }
//    }
//    
//    func add(exerciseType: ExerciseType) {
//        let newExerciseType = ExerciseTypeEntity(context: container.viewContext)
//        newExerciseType.id = exerciseType.id
//        newExerciseType.name = exerciseType.name
//        newExerciseType.isBodyWeight = exerciseType.isBodyWeight
//        newExerciseType.muscleGroups = exerciseType.muscleGroups as NSObject
//    }
//    
//    func convertEntityToExerciseType(_ entity: ExerciseTypeEntity) throws -> ExerciseType {
//        guard let id = entity.id else {
//            throw CoreDaraErrors.exerciseTypeEntityHasNoId
//        }
//        
//        guard let name = entity.name,
//              let muscleGroupObject = entity.muscleGroups
//        else {
//            throw CoreDaraErrors.exerciseTypeEntityHasNotAllRequiredProperties
//        }
//        
//        guard let muscleGroup = muscleGroupObject as? [String] else {
//            throw CoreDaraErrors.muscleGroupsConvertingFailed
//        }
//        
//        let exerciseType = ExerciseType(
//            id: id,
//            name: name,
//            muscleGroups: muscleGroup,
//            isBodyWeight: entity.isBodyWeight
//        )
//        
//        return exerciseType
//    }
//}
