import SwiftUI

struct TrainingRouterView: View {
    @State private var trainingInProgress: Bool
    let trainingManager: TrainingManager
    
    init(dataManager: DataManager) {
        self.trainingInProgress = true
        self.trainingManager = TrainingManager(dataManger: dataManager)
    }
    
// MARK: инициализация TrainingManager происходит здесь, потому что в случае, если TrainingRouterView инициализировалась с тренировкой в процесее, то выяснится это имнно здесь. Исходя из этого, логично создавать TrainingManager здесь и передавать его в CurrentTrainingView
    
    var body: some View {
        if trainingInProgress {
            TrainingGeneralView(trainingManager: trainingManager)
        } else {
            Text("Выбрать программу")
        }
    }
}

