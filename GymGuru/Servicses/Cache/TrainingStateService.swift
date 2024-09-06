import Foundation

// TODO: - Сделать рефакторинг UserDefaults.standard.value(forKey: UserDefaultsKeys.isTrainingInProgress) as? Bool ?? false
    // выделить в отдельный класс

// + поменять название UserDefaultsKeys.doesStartedTrainingExists (то есть поменять название ключа)

final class TrainingStateService: ObservableObject {
    @Published var trainingInProgress: Bool
    @Published var startedTrainingExists: Bool
    
    @Published var selectedProgram: Program?
    
    init() {
        self.trainingInProgress = UserDefaults.standard.value(forKey: UserDefaultsKeys.isTrainingInProgress) as? Bool ?? false
        self.startedTrainingExists = UserDefaults.standard.value(forKey: UserDefaultsKeys.doesStartedTrainingExists) as? Bool ?? false
    }
    
    func isTrainingInProgress() -> Bool {
        return UserDefaults.standard.value(forKey: UserDefaultsKeys.isTrainingInProgress) as? Bool ?? false
    }
    
    func doesStartedTrainingExists() -> Bool {
        return UserDefaults.standard.value(forKey: UserDefaultsKeys.doesStartedTrainingExists) as? Bool ?? false
    }
    
    
    func setTrainingIsInProgress() {
        UserDefaults.standard.set(true, forKey: UserDefaultsKeys.isTrainingInProgress)
        trainingInProgress = true
    }
    
    func setTrainingIsNotInProgress() {
        UserDefaults.standard.set(false, forKey: UserDefaultsKeys.isTrainingInProgress)
        trainingInProgress = false
    }
    
    func setStartedTrainingExists() {
        UserDefaults.standard.set(true, forKey: UserDefaultsKeys.doesStartedTrainingExists)
        trainingInProgress = true
    }
    
    func setStartedTrainingNotExists() {
        UserDefaults.standard.set(false, forKey: UserDefaultsKeys.doesStartedTrainingExists)
        trainingInProgress = false
    }
    
    func selectProgram(_ program: Program) {
        selectedProgram = program
    }

}
