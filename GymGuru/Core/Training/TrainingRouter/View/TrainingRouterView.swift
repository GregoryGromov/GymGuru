import SwiftUI

struct TrainingRouterView: View {
    @StateObject var viewModel: TrainingRouterViewModel

    init(dataManager: DataManager) {
        _viewModel = StateObject(wrappedValue: TrainingRouterViewModel(dataManager: dataManager))
    }

    var body: some View {
        if viewModel.trainingInProgress {
            TrainingGeneralView(trainingManager: viewModel.trainingManager)
        } else {
            Button("Выбрать программу") {
                viewModel.startTraining()
            }
        }
    }
}

