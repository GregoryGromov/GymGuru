import Foundation
import Combine

final class TrainingRouterViewModel: ObservableObject {
    
    let stateService = TrainingStateService()
    
    @Published var trainingInProgress: Bool
    let trainingManager: TrainingManager
    
    private var cancellables = Set<AnyCancellable>()

    init(dataManager: DataManager) {
        self.trainingInProgress = stateService.trainingInProgress
        self.trainingManager = TrainingManager(dataManager: dataManager, stateService: stateService)
        
        stateService.$trainingInProgress
            .receive(on: RunLoop.main)
            .assign(to: \.trainingInProgress, on: self)
            .store(in: &cancellables)
    }

    func startTraining() {
        stateService.setTrainingIsInProgress()
        //trainingManager.startTraining(mode: <#TrainingStartMode#>)
    }
}
