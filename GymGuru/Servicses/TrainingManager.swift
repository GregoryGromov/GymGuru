import Foundation

class TrainingManager: ObservableObject {
    let dataManger: DataManager
    
    @Published var exercises: [Exercise]
    
    init(dataManger: DataManager) {
        self.dataManger = dataManger
        self.exercises = [
            Exercise(nameId: "BecnhPress", sets: [], comment: "Ну такое")
        ]
    }
    
    func addExercise(_ exercise: Exercise) {
        exercises.append(exercise)
    }
    
    func finishTraining() {
        dataManger.editTraining()
    }
}
