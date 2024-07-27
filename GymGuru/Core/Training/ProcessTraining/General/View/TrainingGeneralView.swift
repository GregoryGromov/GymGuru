import SwiftUI

struct TrainingGeneralView: View {
    
    let trainingManager: TrainingManager
    @StateObject var viewModel: TrainingGeneralViewModel
    
    init(trainingManager: TrainingManager) {
        self.trainingManager = trainingManager
        _viewModel = StateObject(wrappedValue: TrainingGeneralViewModel(trainingManager: trainingManager))
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.exercises) { exercise in
                    Text(exercise.nameId)
                }
            }
            Button("Add exercise") {
                viewModel.showAddExerciseView = true
            }
        }
        .sheet(isPresented: $viewModel.showAddExerciseView) {
            AddExerciseView(trainingManager: trainingManager)
        }
    }
}

