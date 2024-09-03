import Foundation

final class DataManager: ObservableObject {
    
    let storageService = TrainingStorageService()
    
    @Published var trainings: [String: Training] = [:]
    
    func addTraining(_ training: Training) {
        storageService.addTraining(training) // Добавляем в хранилище
        trainings[training.id] = training  // Добавляем "локально"
    }
    
    func deleteTraining(withId id: String) {
        storageService
        trainings.removeValue(forKey: id)
    }
    
    func editTraining() {
        
    }
}
