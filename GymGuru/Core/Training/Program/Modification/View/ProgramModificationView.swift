import SwiftUI

struct ProgramModificationView: View {
    @StateObject var viewModel: ProgramModificationViewModel
    @Environment(\.dismiss) var dismiss
    
    init(
        modificationMode: ModificationMode,
        program: Program? = nil,
        programManager: ProgramManager,
        exerciseManager: ExerciseManager
    ) {
        _viewModel = StateObject(
            wrappedValue:
                ProgramModificationViewModel(
                    modificationMode: modificationMode,
                    program: program,
                    programManager: programManager,
                    exerciseManager: exerciseManager
                )
        )
    }
    
    var body: some View {
        NavigationStack {
            List {
                headerSection
                exerciseTypesSection
                actionButtonsSection
                deletingSection
            }
            .navigationTitle( viewModel.getNavigationTitle())
            .sheet(isPresented: $viewModel.addExerciseViewIsShown) {
                AddExerciseView(
                    addingMode: .exerciseType,
                    exerciseStoringManager: viewModel,
                    exerciseManager: viewModel.exerciseManager
                )
            }
        }
    }
    
    private var headerSection: some View {
        Section {
            TextField("Название тренировки", text: $viewModel.name)
            Button("Добавить упражнение") {
                viewModel.showAddExerciseView()
            }
        }
    }
    
    private var exerciseTypesSection: some View {
        Section {
            ForEach(viewModel.exerciseTypes) { exerciseType in
                HStack {
                    Text(exerciseType.name).bold()
                    Spacer()
                    VStack {
                        ForEach(exerciseType.muscleGroups, id: \.self) { muscleGroup in
                            Text(muscleGroup)
                        }
                    }
                }
            }
        }
    }
    
    private var actionButtonsSection: some View {
        Section {
            switch viewModel.modificationMode {
            case .creation:
                Button("Создать") {
                    viewModel.addProgram()
                    dismiss()
                }
            case .editing:
                Button("Сохранить изменения") {
                    viewModel.updateProgram()
                    dismiss()
                }
            }
        }
    }
    
    private var deletingSection: some View {
        Section {
            Button(role: .destructive) {
                viewModel.deleteProgram()
                dismiss()
            } label: {
                Text("Удалить")
            }
        }
    }
}

