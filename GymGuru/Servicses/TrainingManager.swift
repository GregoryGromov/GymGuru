import Foundation

final class TrainingManager: ObservableObject {
    let dataManger: DataManager
    
    @Published var exercises: [String : Exercise]
    let creationDate: Int
    
    init(dataManger: DataManager) {
        self.dataManger = dataManger
        self.creationDate = 2288
        
        do {
            self.exercises = try TrainingManager.loadExercises()
        }
        catch {
            self.exercises = [:]
            print(error)
        }
    }
    
//  MARK: - Exercise modification

    func addExercise(_ exercise: Exercise) {
        exercises[exercise.id] = exercise
        save()
    }
    
    func updateExercise(_ exercise: Exercise) {
        exercises[exercise.id] = exercise
        save()
    }
    
//  MARK: - Data storage
    
    private func save() {
        do {
            saveDate(creationDate)
            try saveExercises(exercises)
        } catch {
            print(error)
        }
    }
        
    private func saveExercises(_ exercises: [String: Exercise]) throws {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(exercises) {
            UserDefaults.standard.set(encoded, forKey: UserDefaultsKeys.exercises)
        } else {
            throw DataStorageError.encodingFailed
        }
    }
    
    static private func loadExercises() throws -> [String: Exercise] {
        if let savedExercises = UserDefaults.standard.object(forKey: UserDefaultsKeys.exercises) as? Data {
            let decoder = JSONDecoder()
            if let loadedExercises = try? decoder.decode([String: Exercise].self, from: savedExercises) {
                return loadedExercises
            } else {
                throw DataStorageError.decodingFailed
            }
        }
        throw DataStorageError.convertingDataFailed
    }
    
    private func saveDate(_ date: Int) {
        UserDefaults.standard.set(date, forKey: UserDefaultsKeys.dateCreation)
    }
    
    private func loadDate() -> Int? {
        return UserDefaults.standard.value(forKey: UserDefaultsKeys.dateCreation) as? Int
    }

//  MARK: -  State management

    func finishTraining() {
        
    }
}
