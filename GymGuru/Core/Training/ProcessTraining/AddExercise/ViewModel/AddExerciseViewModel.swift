import Foundation

class AddExerciseViewModel: ObservableObject {
    let trainingManager: TrainingManager
    
    init(trainingManager: TrainingManager) {
        self.trainingManager = trainingManager
    }
    
    func addExercise(_ exercise: Exercise) {
        trainingManager.addExercise(exercise)
    }
}
