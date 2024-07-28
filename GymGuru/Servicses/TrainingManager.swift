import Foundation

class TrainingManager: ObservableObject {
    let dataManger: DataManager
    
    @Published var exercises: [String : Exercise]
    
    init(dataManger: DataManager) {
        self.dataManger = dataManger
        
        let startExercise = Exercise(nameId: "BecnhPress", sets: [], comment: "Ну такое")
        self.exercises = [
            startExercise.id : startExercise
        ]
    }
    
    func addExercise(_ exercise: Exercise) {
        exercises[exercise.id] = exercise
    }
    
    func updateExercise(_ exercise: Exercise) {
        exercises[exercise.id] = exercise
    }
    
    func finishTraining() {
        dataManger.editTraining()
    }
}
