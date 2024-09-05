import Foundation

class ExerciseManager {
    @Published var exerciseTypes: [String: ExerciseType] = [:]
    
    init() {
        loadExerciseTypes()
    }
    
    private func loadExerciseTypes() {
        do {
            let storedExerciseTypes = try getExerciseTypes()
            self.exerciseTypes = storedExerciseTypes.reduce(into: [String: ExerciseType]()) { dict, exerciseType in
                dict[exerciseType.id] = exerciseType
            }
        } catch {
            print("DEBUG: Error loading [ExerciseType] in ExerciseManager: \(error.localizedDescription)")
        }
    }
        
//    TODO: хранить в отдельном файле
    private let builtInExercises = [
        ExerciseType(
            id: "ex1",
            name: "Жим лежа",
            muscleGroups: ["Грудь", "Плечи", "Трицепс"],
            isBodyWeight: false, 
            isSelected: false
        ),
        ExerciseType(
            id: "ex2",
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
    

    
    func add(exerciseType: ExerciseType) throws {
        // Обновляем локальный кэш упражнений
        self.exerciseTypes[exerciseType.id] = exerciseType
        
        // Обновляем список упражнений в хранилище
        var existingExerciseTypes = try loadExercises()
        
        if !existingExerciseTypes.contains(where: { $0.id == exerciseType.id }) {
            existingExerciseTypes.append(exerciseType)
        } else {
            fatalError("Exercise with the same ID already exists")
        }
        
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
    
    
    func getExerciseTypes(byIDs IDs: [String]) -> [ExerciseType] {
        var exerciseTypes = [ExerciseType]()
        
        for ID in IDs {
            if let exerciseType = getExerciseType(byId: ID) {
                exerciseTypes.append(exerciseType)
            }
        }
        
        return exerciseTypes
    }
    
    
    
    private func getExerciseType(byId id: String) -> ExerciseType? {
        return exerciseTypes[id]
    }
    
    
    func getExerciseTypeName(byId id: String) -> String {
        return exerciseTypes[id]?.name ?? "no name"
    }
}
