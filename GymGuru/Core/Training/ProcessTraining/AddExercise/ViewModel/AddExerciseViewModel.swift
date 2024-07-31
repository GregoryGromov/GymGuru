import Foundation

class AddExerciseViewModel: ObservableObject {
    let trainingManager: TrainingManager
    
    @Published var exerciseTypes: [ExerciseType]
    
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
}
