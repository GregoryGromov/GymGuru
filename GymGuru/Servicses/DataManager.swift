import Foundation

final class DataManager: ObservableObject {
    
    let storageService = TrainingStorageService()
    
    @Published var trainings: [String: Training] = [:]
    
    init() {
        loadTrainings()
    }
    
    private func loadTrainings() {
        do {
            let trainingsFromStorage = try storageService.fetchTrainings()
            self.trainings = Dictionary(uniqueKeysWithValues: trainingsFromStorage.map { ($0.id, $0) })
        } catch {
       
            print("DEBUG: Ошибка изначальной загрузки тренировок в DataManager: \(error)")
        }
    }
    
    func addTraining(_ training: Training) {
        storageService.addTraining(training) // Добавляем в хранилище
        trainings[training.id] = training  // Добавляем "локально"
    }
    
    func deleteTraining(withId id: String) {
        storageService.deleteTraining(byId: id)
        trainings.removeValue(forKey: id)
    }
    
    func editTraining() {
        
    }
}
