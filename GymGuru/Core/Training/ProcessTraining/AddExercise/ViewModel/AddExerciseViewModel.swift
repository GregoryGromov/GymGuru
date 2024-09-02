import Foundation

class AddExerciseViewModel: ObservableObject {
    let trainingManager: TrainingManager
    
    @Published var exerciseTypes: [ExerciseType] = [] {
        didSet {
            updateFilteredExerciseTypes()
        }
    }
    
    @Published var searchQuery: String = "" {
        didSet {
            updateFilteredExerciseTypes()
        }
    }
    
    @Published private(set) var filteredExerciseTypes: [ExerciseType] = []
    
    private func updateFilteredExerciseTypes() {
        if searchQuery.isEmpty {
            filteredExerciseTypes = exerciseTypes
        } else {
            filteredExerciseTypes = exerciseTypes.filter { $0.name.localizedStandardContains(searchQuery) }
        }
    }
    
    @Published var showExerciseTypeCreationView = false
    
    init(trainingManager: TrainingManager) {
        self.trainingManager = trainingManager
        do {
            let exerciseTypes = try ExerciseManager.shared.getExerciseTypes()
            self.exerciseTypes = exerciseTypes
        }
        catch {
            print("DEBUG: <AddExerciseViewModel init>: \(error)")
            self.exerciseTypes = []
        }
    }
    
    func addExercise(_ exercise: Exercise) {
        trainingManager.addExercise(exercise)
    }
    
    func load() throws {
        let exerciseTypes = try ExerciseManager.shared.getExerciseTypes()
        self.exerciseTypes = exerciseTypes
    }
    
    
    func switchExerciseTypeSelection(byId id: String) {
        if let index = exerciseTypes.firstIndex(where: { $0.id == id }) {
            exerciseTypes[index].isSelected.toggle()
        }
    }
    
    func addSelectedExerciseTypes() {
        let selectedExercises = exerciseTypes
                .filter { $0.isSelected }
                .map { convertExerciseTypeToExercise($0) }
        
        for exercise in selectedExercises {
            addExercise(exercise)
        }
    }
    
    private func convertExerciseTypeToExercise(
        _ exerciseType: ExerciseType
    ) -> Exercise {
        return Exercise(
            id: UUID().uuidString,
            date: Date().toInt,
            typeId: exerciseType.id,
            sets: []
        )
    }
}
