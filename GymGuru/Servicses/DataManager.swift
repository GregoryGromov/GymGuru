import Foundation

class DataManager: ObservableObject {
    @Published var trainings: [String: Training] = [:]
    
    func addTraining(_ training: Training) {
        trainings[training.id] = training
    }
    
    func deleteTraining(withId id: String) {
        trainings.removeValue(forKey: id)
    }
    
    func editTraining() {
        
    }
}
