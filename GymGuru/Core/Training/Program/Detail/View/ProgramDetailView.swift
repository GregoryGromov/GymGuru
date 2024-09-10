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
                infoSection
                exerciseTypesSection
                startTrainingButton
            }
            .toolbar {
                closeToolBarItem
            }
        }
    }
    
    
    private var infoSection: some View {
        Section {
            Text(viewModel.program.name)
        }
    }
    
    private var exerciseTypesSection: some View {
        Section {
            ForEach(viewModel.program.exerciseTypeIDs, id: \.self) { exerciseTypeID in
                HStack {
                    Text(viewModel.exerciseManager.getExerciseTypeName(byId: exerciseTypeID)) //!
                    Spacer()
                    Image(systemName: "checkmark.circle")
                }
            }
        }
    }
    
    private var startTrainingButton: some View {
        Section {
            Button("Начать тренировку") {
                viewModel.startTraining()
                dismiss()
            }
        }
    }
    
    private var closeToolBarItem: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button("Закрыть") {
                dismiss()
            }
        }
    }
}

