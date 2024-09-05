import SwiftUI

struct ProgramDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel: ProgramDetailViewModel
    
    init(
        program: Program,
        stateService: TrainingStateService,
        exerciseManager: ExerciseManager
    ) {
        _viewModel = StateObject(
            wrappedValue:
                ProgramDetailViewModel(
                    program: program,
                    stateService: stateService,
                    exerciseManager: exerciseManager
                )
        )
    }
    
    

    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Text(viewModel.program.name)
                }
                
                Section {
                    ForEach(viewModel.program.exerciseTypeIDs, id: \.self) { exerciseTypeID in
                        HStack {
                            Text(viewModel.exerciseManager.getExerciseTypeName(byId: exerciseTypeID)) //!
                            Spacer()
                            Image(systemName: "checkmark.circle")
                        }
                    }
                }
                
                Section {
                    Button("Начать тренировку") {
                        viewModel.startTraining()
                        dismiss()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Закрыть") {
                        dismiss()
                    }
                }
            }
        }
    }
}

