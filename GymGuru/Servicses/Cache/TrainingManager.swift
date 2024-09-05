import Foundation

enum TrainingStartMode {
    case free
    case withProgram
}

final class TrainingManager: ObservableObject, ExerciseAddable {
    
    let dataManager: DataManager
    let stateService: TrainingStateService
    
    @Published var exercises: [String : Exercise]
    @Published var comment: String?
    var creationDate: Int?
    
    init(dataManager: DataManager, stateService: TrainingStateService) {
        self.dataManager = dataManager
        self.stateService = stateService
        
        if stateService.isTrainingInProgress() {
            print("DEGUG: Тренировка в процессе")
            self.creationDate = TrainingManager.loadDate() ?? Date().toInt
            self.exercises = TrainingManager.safeLoadExercises()
        } else {
            self.exercises = [:]
            self.comment = nil
        }
    }
    
//  MARK: - Exercise modification

    func addExercise(_ exercise: Exercise) {
        exercises[exercise.id] = exercise
        save()
    }
    
    //КОСТЫЛЬ
    func addExerciseType(_ exerciseType: ExerciseType) {}
    
    
    func updateExercise(_ exercise: Exercise) {
        exercises[exercise.id] = exercise
        save()
    }
    
    func deleteExercise(byId id: String) {
        exercises[id] = nil
        save()
    }
    
//  MARK: - Data storage
    
    private func save() {
        saveDate(creationDate!)
        do {
            try saveExercises(exercises)
        } catch {
            print("DEBUG: Error saving exercises - \(error)")
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
    
    static private func safeLoadExercises() -> [String: Exercise] {
        do {
            return try loadExercises()
        } catch {
            print("DEBUG: Error loading exercises - \(error)")
            return [:]
        }
    }
    
    private func saveDate(_ date: Int) {
        UserDefaults.standard.set(date, forKey: UserDefaultsKeys.dateCreation)
    }
    
    static private func loadDate() -> Int? {
        return UserDefaults.standard.value(forKey: UserDefaultsKeys.dateCreation) as? Int
    }

//  MARK: -  State management
    
    func startTraining(mode: TrainingStartMode, program: Program? = nil) {
        switch mode {
        case .free:
            self.creationDate = Date().toInt
            print("DEGUG: Начата новая свободная тренировка")
        case .withProgram:
            guard let program = program else {
                print("DEBUG: Нет программы!")
                return
            }
            
            print("DEGUG: Начата новая тренировка по программе")
        }
        
        
    }

    func finishTraining() {
        let exerciseArray = Array(exercises.values)
        
        let newTraining = Training(
            id: UUID().uuidString, // ПОДУМАТЬ НАД ЭТИМ
            dateStart: creationDate!,
            dateEnd: Date().toInt,
            exercises: exerciseArray,
            programId: "no id", // КОСТЫЛЬ
            comment: comment
        )
        
        dataManager.addTraining(newTraining)
        stateService.setTrainingIsNotInProgress()
    }
}
