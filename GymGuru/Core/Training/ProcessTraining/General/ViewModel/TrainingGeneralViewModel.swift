import Foundation
import Combine

class TrainingGeneralViewModel: ObservableObject {
    
    let trainingManager: TrainingManager
    
    @Published var exercises = [Exercise]()

    @Published var foldedExerciseIDs = [String]()
    @Published var showAddExerciseView = false
    @Published var showExerciseDetailView = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init(trainingManager: TrainingManager) {
        self.trainingManager = trainingManager
        
        trainingManager.$exercises
            .sink { [weak self] exercises in
                self?.exercises = exercises
            }
            .store(in: &cancellables)
    }
    
}
