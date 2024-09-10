import Foundation

protocol ExerciseModificatable {
    func addExercise(_ exercise: Exercise)
    func updateExercise(_ exercise: Exercise)
    func deleteExercise(byId id: String) 
}
