import Foundation
import Combine

final class ProgramListViewModel: ObservableObject {
    let stateService: TrainingStateService
    let programManager: ProgramManager
    let exerciseManager: ExerciseManager
    
    @Published var programs: [Program] = []
    
    @Published var selectedProgram: Program?
    @Published var programDetailViewIsShown = false
    
    @Published var programCreationViewIsShown = false
    @Published var programEditingViewIsShown = false
    
    private var cancellables = Set<AnyCancellable>()

    init(stateService: TrainingStateService, exerciseManager: ExerciseManager) {
        self.stateService = stateService
        self.exerciseManager = exerciseManager
        
        self.programManager = ProgramManager(
            exerciseManager: exerciseManager
        )
        
        programManager.$programs
            .sink { [weak self] programs in
                self?.programs = programs.sorted { $0.dateCreation < $1.dateCreation }
            }
            .store(in: &cancellables)
        
        loadPrograms()
    }
    
    func addProgram(_ program: Program) {
        programManager.addProgram(program)
    }
    
    func loadPrograms() {
        programManager.loadPrograms()
    }
    
    func deleteProgram(byId id: String) {
        programManager.deleteProgram(byId: id)
    }
    
    func selectProgram(with program: Program) {
        selectedProgram = program
        programDetailViewIsShown = false
    }
}
