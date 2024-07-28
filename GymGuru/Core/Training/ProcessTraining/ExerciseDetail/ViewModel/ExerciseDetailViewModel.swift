import Foundation

class ExerciseDetailViewModel: ObservableObject {
    let trainingManager: TrainingManager
    
    var exercise: Exercise
    
    init(trainingManager: TrainingManager, exercise: Exercise) {
        self.trainingManager = trainingManager
        self.exercise = exercise
    }
    
    func addSet(weight: Float, reps: Int) {
        let set = ESet(weight: weight, reps: reps)
        exercise.sets.append(set)
    }
    
    func save() {
        trainingManager.updateExercise(exercise)
    }
}
