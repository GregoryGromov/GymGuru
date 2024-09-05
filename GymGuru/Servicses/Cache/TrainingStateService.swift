import Foundation

final class TrainingStateService: ObservableObject {
    @Published var trainingInProgress: Bool
    
    init() {
        self.trainingInProgress = UserDefaults.standard.value(forKey: UserDefaultsKeys.isTrainingInProgress) as? Bool ?? false
    }
    
    func isTrainingInProgress() -> Bool {
        return UserDefaults.standard.value(forKey: UserDefaultsKeys.isTrainingInProgress) as? Bool ?? false
    }
    
    func setTrainingIsInProgress() {
        UserDefaults.standard.set(true, forKey: UserDefaultsKeys.isTrainingInProgress)
        trainingInProgress = true
    }
    
    func setTrainingIsNotInProgress() {
        UserDefaults.standard.set(false, forKey: UserDefaultsKeys.isTrainingInProgress)
        trainingInProgress = false
    }
}
