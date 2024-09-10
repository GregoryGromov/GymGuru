import Foundation

protocol ExerciseModificatable {
    func updateExercise(_ exercise: Exercise)
    func deleteExercise(byId id: String) 
}
