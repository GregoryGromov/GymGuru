import Foundation

class StatisticsService: ObservableObject {
    let dataManager: TrainingManageable
    
    init(dataManager: TrainingManageable) {
        self.dataManager = dataManager
    }
    
    func getExerciseTypeStatistics(typeId: String) -> [ExerciseTypeStatisticsModel]? {
        var statistics = [ExerciseTypeStatisticsModel]()
        
        for (trainingId, training) in dataManager.trainings {
            guard let exercise = findExercise(withTypeId: typeId, in: training) else {
                continue
            }
            
            if exercise.sets.isEmpty {
                continue
            }
            
            let maxWeight = getMaxWeight(from: exercise.sets)
            
            let statisticsModel = ExerciseTypeStatisticsModel(
                id: UUID().uuidString,
                exerciseTypeId: typeId,
                trainingId: trainingId,
                date: exercise.date.toDate,
                maxWeight: maxWeight
            )
            
            statistics.append(statisticsModel)
        }
        return statistics
    }
    
    private func findExercise(withTypeId typeId: String, in training: Training) -> Exercise? {
        for exercise in training.exercises {
            if exercise.typeId == typeId {
                return exercise
            }
        }
        return nil
    }
    
    private func getMaxWeight(from sets: [ESet]) -> Float {
        var maxWeight = -Float.greatestFiniteMagnitude
        for eSet in sets {
            if eSet.weight > maxWeight {
                maxWeight = eSet.weight
            }
        }
        return maxWeight
    }
}
