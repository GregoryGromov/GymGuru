import Foundation
import Combine

class TrainingGeneralViewModel: ObservableObject {
    
    let trainingManager: TrainingManager
    
    @Published var exercises = [Exercise]()

    @Published var foldedExerciseIDs = [String]()
    @Published var showAddExerciseView = false
    @Published var showExerciseDetailView = false
    
    @Published var selectedExercise: Exercise? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    init(trainingManager: TrainingManager) {
        self.trainingManager = trainingManager
        
        trainingManager.$exercises
            .map { $0.map { $1 } } // Преобразование значений словаря в массив
            .sink { [weak self] exercises in
                self?.exercises = exercises
            }
            .store(in: &cancellables)
    }
}
