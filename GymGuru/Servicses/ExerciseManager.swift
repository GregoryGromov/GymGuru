import Foundation

class ExerciseManager {
    
    static let shared = ExerciseManager()
        
//    TODO: хранить в отдельном файле
    private let builtInExercises = [
        ExerciseType(
            id: UUID().uuidString,
            name: "Жим лежа",
            muscleGroups: ["Грудь", "Плечи", "Трицепс"],
            isBodyWeight: false, 
            isSelected: false
        ),
        ExerciseType(
            id: UUID().uuidString,
            name: "Тяга блока сидя",
            muscleGroups: ["Спина", "Плечи", "Бицепс"],
            isBodyWeight: false,
            isSelected: false
        )
    ]
    
    func getExerciseTypes() throws -> [ExerciseType] {
        let builtInExerciseTypes = ExerciseType.MOCK1
        let customExerciseTypes = try loadExercises()
        let allExercise = builtInExerciseTypes + customExerciseTypes
        
        return allExercise
    }
    
    private var documentsDirectory: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    private var fileURL: URL {
        return documentsDirectory.appendingPathComponent("exercises.json")
    }
    
    func saveExerciseTypes(_ exercises: [ExerciseType]) throws {
        do {
            let data = try JSONEncoder().encode(exercises)
            try data.write(to: fileURL) 
        } catch {
            throw error
        }
    }
    
    func loadExercises() throws -> [ExerciseType] {
        do {
            let data = try Data(contentsOf: fileURL) // Чтение данных из файла
            let exercises = try JSONDecoder().decode([ExerciseType].self, from: data) //
            return exercises
        } catch {
            throw error
        }
    }
    
    func addExercise(_ exerciseType: ExerciseType) throws {
        var existingExerciseTypes = try loadExercises()
        existingExerciseTypes.append(exerciseType)
        try saveExerciseTypes(existingExerciseTypes)
    }
    
    func addExercises(_ exerciseTypes: [ExerciseType]) throws {
        var existingExerciseTypes = try loadExercises()
        existingExerciseTypes.append(contentsOf: exerciseTypes)
        try saveExerciseTypes(existingExerciseTypes)
    }
    
    func updateExercise(_ exerciseType: ExerciseType) throws {
        var existingExerciseTypes = try loadExercises()
        for index in existingExerciseTypes.indices {
            if existingExerciseTypes[index].id == exerciseType.id {
                existingExerciseTypes[index] = exerciseType
                break
            }
        }
        try saveExerciseTypes(existingExerciseTypes)
    }
    
    func deleteExerciseType(byId id: String) throws {
        var existingExerciseTypes = try loadExercises()
        for index in existingExerciseTypes.indices {
            if existingExerciseTypes[index].id == id {
                existingExerciseTypes.remove(at: index)
                break
            }
        }
        try saveExerciseTypes(existingExerciseTypes)
    }
    
    func deleteAllExerciseTypes() throws {
        try saveExerciseTypes([])
    }
    
    
    
    // TODO: Это временное решение (так как оно непроизводительное)
//    ПО идее нужно будет сделать этот класс не shared, а настоящим и хранить в нем все имеющиеся типы
    func getExerciseType(byId id: String) -> String {
        let allExerciseTypes = try! getExerciseTypes()        
        for type in allExerciseTypes {
            if type.id == id {
                return type.name
            }
        }
        return "no name"
    }
}
