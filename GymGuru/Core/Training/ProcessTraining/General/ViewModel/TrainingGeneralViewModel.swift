import Foundation
import Combine

class TrainingGeneralViewModel: ObservableObject {
    
    
    
    let trainingManager: TrainingManager
    
    @Published var exercises = [Exercise]()

    @Published var showAddExerciseView = false
    @Published var showExerciseDetailView = false
    
    @Published var selectedExercise: Exercise? = nil
    
    @Published var secondsElapsed: Int = 0
    private var timer: Timer?
    private var isRunning = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init(trainingManager: TrainingManager) {
        self.trainingManager = trainingManager
        print("Date().toInt", Date().toInt)
        print("trainingManager.creationDate", trainingManager.creationDate)
        self.secondsElapsed = Date().toInt - trainingManager.creationDate!
        
        trainingManager.$exercises
            .map { $0.map { $1 } } // Преобразование значений словаря в массив
            .sink { [weak self] exercises in
                self?.exercises = exercises.sorted { $0.date < $1.date }
            }
            .store(in: &cancellables)
        
        startStopwatch()
    }
    
    func deleteExercise(byId id: String) {
        trainingManager.deleteExercise(byId: id)
    }
    
    //  MARK: - Training state control
    
    func finishTraining() {
        trainingManager.finishTraining()
    }
    
    //  MARK: - Stopwatch control
    
    func startStopwatch() {
        guard !isRunning else { return }
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.secondsElapsed += 1
        }
    }
    
    func stopStopwatch() {
        guard isRunning else { return }
        timer?.invalidate()
        timer = nil
        isRunning = false
    }
    
    func resetStopwatch() {
        stopStopwatch()
        secondsElapsed = 0
    }
    
    
}
