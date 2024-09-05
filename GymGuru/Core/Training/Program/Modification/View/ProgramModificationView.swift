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
                Section {
                    Text(viewModel.id)
                        .foregroundStyle(.purple)
                }
                
                Section {
                    TextField("Название тренировки", text: $viewModel.name)
                    Button("Добавить упражнение") {
                        viewModel.showAddExerciseView()
                    }
                }
                
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
                
                Section {
                    Button(role: .destructive) {
                        viewModel.deleteProgram()
                        dismiss()
                    } label: {
                        Text("Удалить")
                    }

                }
            }
            .navigationTitle( viewModel.modificationMode == .creation
                              ? "Создание программы"
                              : "Редактирование программы"
            )
            .sheet(isPresented: $viewModel.addExerciseViewIsShown) {
                AddExerciseView(
                    addingMode: .exerciseType,
                    exerciseStoringManager: viewModel,
                    exerciseManager: viewModel.exerciseManager
                )
            }
        }
        
    }
}

