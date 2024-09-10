import Foundation

enum TrainingStartMode {
    case free
    case withProgram
}

final class TrainingManager: ObservableObject, ExerciseAddable {
    let dataManager: DataManager
    let stateService: TrainingStateService
    let startMode: TrainingStartMode
    
    @Published var exercises: [String : Exercise]
    @Published var comment: String?
    var creationDate: Int
    
    init(
        mode: TrainingStartMode,
        program: Program? = nil,
        dataManager: DataManager,
        stateService: TrainingStateService,
        exerciseManager: ExerciseManager
    ) {
        self.dataManager = dataManager
        self.stateService = stateService
        self.startMode = mode
        
        if stateService.doesStartedTrainingExists() {
            self.creationDate = TrainingManager.loadDate() ?? Date().toInt
            self.exercises = TrainingManager.safeLoadExercises()
        } else {
            switch mode {
            case .free:
                self.exercises = [:]
            case .withProgram:
                if let program = program {
                    let exerciseTypes = exerciseManager.getExerciseTypes(byIDs: program.exerciseTypeIDs)
                    var exercises = [String : Exercise]()
                    for exerciseType in exerciseTypes {
                        let newExercise = Exercise(
                            id: UUID().uuidString,
                            date: Date().toInt,
                            typeId: exerciseType.id,
                            sets: []
                        )
                        exercises[newExercise.id] = newExercise
                    }
                    self.exercises = exercises
                } else {
                    exercises = [:]
                }
            }
            
            self.comment = nil
            self.creationDate = Date().toInt
            
            stateService.setTrainingIsInProgress()
            stateService.setStartedTrainingExists()
        }
        
        save()
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
        saveDate(creationDate)
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

    func finishTraining() {
        let exerciseArray = Array(exercises.values)
        
        let newTraining = Training(
            id: UUID().uuidString, // TODO!
            dateStart: creationDate,
            dateEnd: Date().toInt,
            exercises: exerciseArray,
            programId: "no id", // TODO!
            comment: comment
        )
        
        dataManager.addTraining(newTraining)
        
        stateService.setStartedTrainingNotExists()  // + Сделать удаление этой тренировки из UserDefaults
        stateService.setTrainingIsNotInProgress()
    }
}
