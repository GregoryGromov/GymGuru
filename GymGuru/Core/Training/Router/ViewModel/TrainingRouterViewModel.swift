import Foundation
import Combine

final class TrainingRouterViewModel: ObservableObject {
    
    let stateService = TrainingStateService()
    let dataManager: DataManager
    
    @Published var trainingInProgress: Bool
    
    private var cancellables = Set<AnyCancellable>()

    init(dataManager: DataManager) {
        self.trainingInProgress = stateService.trainingInProgress
        self.dataManager = dataManager
        
        stateService.$trainingInProgress
            .receive(on: RunLoop.main)
            .assign(to: \.trainingInProgress, on: self)
            .store(in: &cancellables)
    }

    func startTraining() {
        stateService.setTrainingIsInProgress()
    }
    
    func detectTrainingCreationMode() -> TrainingStartMode {
        if stateService.selectedProgram == nil {
            return .free
        } else {
            return .withProgram
        }
    }
    
    func getSelectedProgram() -> Program? {
        return stateService.selectedProgram
    }
}
