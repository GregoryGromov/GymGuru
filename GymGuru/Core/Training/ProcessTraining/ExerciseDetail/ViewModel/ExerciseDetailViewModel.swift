import Foundation

final class ExerciseDetailViewModel: ObservableObject {
    let trainingManager: ExerciseModificatable
    
    @Published var exercise: Exercise
    
    @Published var weight = ""
    @Published var reps = ""
    @Published var selectedSetId: String?
    
    init(trainingManager: ExerciseModificatable, exercise: Exercise) {
        self.trainingManager = trainingManager
        self.exercise = exercise
    }
    
//    MARK: - UI methods
    
    func switchSetSelection(byId id: String) {
        if selectedSetId == id {
            selectedSetId = nil
            weight = ""
            reps = ""
        } else {
            selectedSetId = id
            if let selectedSet = getSet(byId: id) {
                weight = String(selectedSet.weight)
                reps = String(selectedSet.reps)
            }
        }
    }
    
    private func getSet(byId id: String) -> ESet? {
        for index in exercise.sets.indices {
            if exercise.sets[index].id == id {
                return exercise.sets[index]
            }
        }
        return nil
    }
    
//    MARK: - Data updating methods
    
    func addSet(weight: Float, reps: Int) {
        let set = ESet(id: UUID().uuidString, weight: weight, reps: reps)
        exercise.sets.append(set)
    }
    
    func updateSet(byId id: String, weight: Float, reps: Int) {
        for index in exercise.sets.indices {
            if exercise.sets[index].id == id {
                exercise.sets[index].weight = weight
                exercise.sets[index].reps = reps
                return
            }
        }
    }
    
    func deleteSet(byId id: String) {
        for index in exercise.sets.indices {
            if exercise.sets[index].id == id {
                exercise.sets.remove(at: index)
                return
            }
        }
    }
    
    func save() {
        trainingManager.updateExercise(exercise)
    }
}
