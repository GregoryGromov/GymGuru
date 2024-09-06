import SwiftUI

struct TrainingRouterView: View {
    @StateObject var viewModel: TrainingRouterViewModel
    
    let exerciseManager: ExerciseManager

    init(
        dataManager: DataManager,
        exerciseManager: ExerciseManager
    ) {
        _viewModel = StateObject(
            wrappedValue:
                TrainingRouterViewModel(dataManager: dataManager)
        )
        self.exerciseManager = exerciseManager
    }

    var body: some View {
        if viewModel.trainingInProgress {
            TrainingGeneralView(
                mode: viewModel.detectTrainingCreationMode(),
                program: viewModel.getSelectedProgram(),
                dataManager: viewModel.dataManager,
                stateService: viewModel.stateService,
                exerciseManager: exerciseManager
            )
        } else {
            VStack {
                ProgramListView(
                    stateService: viewModel.stateService, 
                    exerciseManager: exerciseManager
                )
                
                Button("Выбрать программу") {
                    viewModel.startTraining()
                }
                .backgroundStyle(.blue)
            }
            
        }
    }
}

