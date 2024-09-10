import Foundation

struct ExerciseTypeStatisticsModel: Identifiable {
    let id: String
    let exerciseTypeId: String
    let trainingId: String
    let date: Date
    let maxWeight: Float
}
