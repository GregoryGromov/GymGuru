import SwiftUI

struct AddExerciseView: View {
    
    @StateObject var viewModel: AddExerciseViewModel
    
    init(trainingManager: TrainingManager) {
        _viewModel = StateObject(wrappedValue: AddExerciseViewModel(trainingManager: trainingManager))
    }
    
    @State var name = ""
    
    var body: some View {
        VStack {
            TextField("Name", text: $name)
            Button("Add exercise") {
                let newExercise = Exercise(
                    id: UUID().uuidString,
                    date: 128980923098,
                    nameId: name,
                    sets: []
                )
                viewModel.addExercise(newExercise)
            }
            Spacer()
        }
    }
}

