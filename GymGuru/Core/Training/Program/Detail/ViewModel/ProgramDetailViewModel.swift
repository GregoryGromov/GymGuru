import Foundation

final class ProgramDetailViewModel: ObservableObject {
    let program: Program
    let stateService: TrainingStateService
    let exerciseManager: ExerciseManager
    
    init(
        program: Program,
        stateService: TrainingStateService,
        exerciseManager: ExerciseManager
    ) {
        self.program = program
        self.stateService = stateService
        self.exerciseManager = exerciseManager
    }
    
    
    func startTraining() {
        stateService.setTrainingIsInProgress()
        stateService.selectProgram(program)
    }
}
