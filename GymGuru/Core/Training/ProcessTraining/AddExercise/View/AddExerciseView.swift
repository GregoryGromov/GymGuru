import SwiftUI

struct AddExerciseView: View {
    
//    let trainingManager: TrainingManager // вообще, можно убрать
    @StateObject var viewModel: AddExerciseViewModel
    
    init(trainingManager: TrainingManager) {
//        self.trainingManager = trainingManager
        _viewModel = StateObject(wrappedValue: AddExerciseViewModel(trainingManager: trainingManager))
    }
    
    @State var name = ""
    
    var body: some View {
        VStack {
            TextField("Name", text: $name)
            Button("Add exercise") {
                let newExercise = Exercise(
                    nameId: name,
                    sets: []
                )
                viewModel.addExercise(newExercise)
            }
        }
    }
}

