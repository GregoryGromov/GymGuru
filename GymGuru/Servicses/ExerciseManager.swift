import Foundation

class ExerciseManager {
    
    static let shared = ExerciseManager()
    
    let dataService = CoreDataService()
    
    private let builtInExercises = [
        ExerciseType(
            id: UUID().uuidString,
            name: "Жим лежа",
            muscleGroups: ["Грудь", "Плечи", "Трицепс"],
            isBodyWeight: false
        ),
        ExerciseType(
            id: UUID().uuidString,
            name: "Тяга блока сидя",
            muscleGroups: ["Спина", "Плечи", "Бицепс"],
            isBodyWeight: false
        )
    ]
    
    func getExercises() -> [ExerciseType] {
        
//        извлекаем кастомные упражнения (exerciseTypeEntities) из хранилища
        let exerciseTypeEntities = dataService.fetch(ExerciseTypeEntity.self)
        
//        конвертируем в exerciseType
        
        
//        делаем слияние кастомных и не кастомных
        
//        возвращаем получившийся результат
        
        return []
    }
    
    func addExercise(_ exercise: ExerciseType) {
        
//        сохраняем тип упражнения в CoreData
        
    }
    
    func updateExercise(_ exercise: ExerciseType) {
        
    }
    
    func deleteExercise(_ exercise: ExerciseType) {
        
    }
    
    
}
