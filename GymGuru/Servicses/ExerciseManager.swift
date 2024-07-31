import Foundation

class ExerciseManager {
    
    static let shared = ExerciseManager()
        
//    TODO: хранить в отдельном файле
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
    
    func saveExercises(_ exercises: [ExerciseType]) throws {
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
        try saveExercises(existingExerciseTypes)
    }
    
    func addExercises(_ exerciseTypes: [ExerciseType]) throws {
        var existingExerciseTypes = try loadExercises()
        existingExerciseTypes.append(contentsOf: exerciseTypes)
        try saveExercises(existingExerciseTypes)
    }
    
    func updateExercise(_ exerciseType: ExerciseType) throws {
        var existingExerciseTypes = try loadExercises()
        for index in existingExerciseTypes.indices {
            if existingExerciseTypes[index].id == exerciseType.id {
                existingExerciseTypes[index] = exerciseType
                break
            }
        }
        try saveExercises(existingExerciseTypes)
    }
    
    func deleteExerciseType(byId id: String) throws {
        var existingExerciseTypes = try loadExercises()
        for index in existingExerciseTypes.indices {
            if existingExerciseTypes[index].id == id {
                existingExerciseTypes.remove(at: index)
                break
            }
        }
        try saveExercises(existingExerciseTypes)
    }
    
    func deleteAllExerciseTypes() throws {
        try saveExercises([])
    }
}
