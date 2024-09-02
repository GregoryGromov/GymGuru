//import Foundation
//
//final class TrainingManager2: ObservableObject {
//    private let dataManager: DataManager
//    private let stateService: TrainingStateService
//    
//    @Published var exercises: [String: Exercise]
//    @Published var comment: String?
//    private(set) var creationDate: Int
//    
//    init(dataManager: DataManager, stateService: TrainingStateService) {
//        self.dataManager = dataManager
//        self.stateService = stateService
//        
//        if stateService.isTrainingInProgress() {
//            print("DEBUG: Тренировка в процессе")
//            self.creationDate = TrainingManager.loadDate() ?? Date().toInt
//            self.exercises = TrainingManager.safeLoadExercises()
//        } else {
//            print("DEBUG: Тренировка не в процессе")
//            self.creationDate = Date().toInt
//            self.exercises = [:]
//        }
//    }
//    
//    // MARK: - Exercise modification
//    
//    func addExercise(_ exercise: Exercise) {
//        exercises[exercise.id] = exercise
//        save()
//    }
//    
//    func updateExercise(_ exercise: Exercise) {
//        exercises[exercise.id] = exercise
//        save()
//    }
//    
//    func deleteExercise(byId id: String) {
//        exercises.removeValue(forKey: id)
//        save()
//    }
//    
//    // MARK: - Data storage
//    
//    private func save() {
//        saveDate(creationDate)
//        do {
//            try saveExercises(exercises)
//        } catch {
//            print("DEBUG: Error saving exercises - \(error)")
//        }
//    }
//    
//    private func saveExercises(_ exercises: [String: Exercise]) throws {
//        let encoder = JSONEncoder()
//        guard let encoded = try? encoder.encode(exercises) else {
//            throw DataStorageError.encodingFailed
//        }
//        UserDefaults.standard.set(encoded, forKey: UserDefaultsKeys.exercises)
//    }
//    
//    static private func safeLoadExercises() -> [String: Exercise] {
//        do {
//            return try loadExercises()
//        } catch {
//            print("DEBUG: Error loading exercises - \(error)")
//            return [:]
//        }
//    }
//    
//    static private func loadExercises() throws -> [String: Exercise] {
//        guard let savedExercises = UserDefaults.standard.data(forKey: UserDefaultsKeys.exercises) else {
//            throw DataStorageError.convertingDataFailed
//        }
//        let decoder = JSONDecoder()
//        guard let loadedExercises = try? decoder.decode([String: Exercise].self, from: savedExercises) else {
//            throw DataStorageError.decodingFailed
//        }
//        return loadedExercises
//    }
//    
//    private func saveDate(_ date: Int) {
//        UserDefaults.standard.set(date, forKey: UserDefaultsKeys.dateCreation)
//    }
//    
//    private static func loadDate() -> Int? {
//        return UserDefaults.standard.integer(forKey: UserDefaultsKeys.dateCreation).nonZeroValue
//    }
//    
//    // MARK: - State management
//    
//    func finishTraining() {
//        let exerciseArray = Array(exercises.values)
//        let newTraining = Training(
//            dateStart: creationDate,
//            dateEnd: Date().toInt,
//            exercises: exerciseArray,
//            programId: "no id", // Placeholder
//            comment: comment
//        )
//        dataManager.addTraining(newTraining)
//        stateService.setTrainingIsNotInProgress()
//    }
//}
//
//private extension Int {
//    var nonZeroValue: Int? {
//        return self != 0 ? self : nil
//    }
//}
