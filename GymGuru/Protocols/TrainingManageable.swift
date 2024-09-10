import Foundation

protocol TrainingManageable {
    var trainings: [String: Training] { get }
    func deleteTraining(withId id: String)
}

