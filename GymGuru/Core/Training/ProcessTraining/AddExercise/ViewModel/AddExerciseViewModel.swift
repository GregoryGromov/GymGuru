import Foundation

enum AddingExeriseMode {
    case exercise
    case exerciseType
}

class AddExerciseViewModel: ObservableObject {
    let addingMode: AddingExeriseMode
    
    let exerciseStoringManager: any ExerciseAddable
    let exerciseManager: ExerciseManager
    
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
    
    init(
        addingMode: AddingExeriseMode,
        trainingManager: any ExerciseAddable,
        exerciseManager: ExerciseManager
    ) {
        self.addingMode = addingMode
            self.exerciseStoringManager = trainingManager
            self.exerciseManager = exerciseManager
            do {
                let exerciseTypes = try exerciseManager.getExerciseTypes()
                self.exerciseTypes = exerciseTypes
            }
            catch {
                print("DEBUG: <AddExerciseViewModel init>: \(error)")
                self.exerciseTypes = []
            }
        }
    
    func addExercise(_ exercise: Exercise) {
        exerciseStoringManager.addExercise(exercise)
    }
    
    func addExerciseType(_ exerciseType: ExerciseType) {
        exerciseStoringManager.addExerciseType(exerciseType)
    }
    
    func load() throws {
        let exerciseTypes = try exerciseManager.getExerciseTypes()
        self.exerciseTypes = exerciseTypes
    }
    
    
    func switchExerciseTypeSelection(byId id: String) {
        if let index = exerciseTypes.firstIndex(where: { $0.id == id }) {
            exerciseTypes[index].isSelected.toggle()
        }
    }
    
    func addSelectedExercises() {
        let selectedExercises = exerciseTypes
                .filter { $0.isSelected }
                .map { convertExerciseTypeToExercise($0) }
        
        for exercise in selectedExercises {
            addExercise(exercise) //!
        }
    }
    
    func addSelectedObjects() {
        switch addingMode {
        case .exercise:
            addSelectedExercises()
        case .exerciseType:
            addSelectedExerciseTypes()
        }
    }
    
    func addSelectedExerciseTypes() {
        let selectedExercisesTypes = exerciseTypes
                .filter { $0.isSelected }
                
        for exerciseType in selectedExercisesTypes {
            addExerciseType(exerciseType)
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
