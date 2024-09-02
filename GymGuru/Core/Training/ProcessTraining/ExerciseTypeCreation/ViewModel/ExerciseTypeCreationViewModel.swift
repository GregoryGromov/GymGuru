import Foundation

class ExerciseTypeCreationViewModel: ObservableObject {
    
    @Published var name = ""
    @Published var isBodyWeight = false
    @Published var selectedMuscleGroups = [String]()
    
    let muscleGroups = ["Грудь", "Спина", "Руки", "Плечи"]
    
//    MARK: - Data managment
    
    func save() throws {
        let newExerciseType = ExerciseType(
            id: UUID().uuidString,
            name: name,
            muscleGroups: selectedMuscleGroups,
            isBodyWeight: isBodyWeight,
            isSelected: false
        )
        try ExerciseManager.shared.addExercise(newExerciseType)
    }
    
    
//    MARK: - Selecting
    
    func switchSelection(muscleGroup: String) {
        if isSelected(muscleGroup: muscleGroup) {
            deselect(muscleGroup: muscleGroup)
        } else {
            selectedMuscleGroups.append(muscleGroup)
        }
    }
    
    func isSelected(muscleGroup: String) -> Bool {
        return selectedMuscleGroups.contains(muscleGroup)
    }
    
    private func deselect(muscleGroup: String) {
        for index in selectedMuscleGroups.indices {
            if selectedMuscleGroups[index] == muscleGroup {
                selectedMuscleGroups.remove(at: index)
                return
            }
        }
    }
}
