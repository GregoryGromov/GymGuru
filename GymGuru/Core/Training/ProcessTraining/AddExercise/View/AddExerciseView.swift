import SwiftUI

struct AddExerciseView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: AddExerciseViewModel
    
    let exerciseManager: ExerciseManager
    
    init(
        addingMode: AddingExeriseMode,
        exerciseStoringManager: ExerciseAddable,
        exerciseManager: ExerciseManager
    ) {
        _viewModel = StateObject(
            wrappedValue: AddExerciseViewModel(
                addingMode: addingMode,
                trainingManager: exerciseStoringManager,
                exerciseManager: exerciseManager
            )
        )
        self.exerciseManager = exerciseManager
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                exerciseTypesList
                addExerciseToTrainingButton
                exerciseTypeCreationButton
            }
            .sheet(isPresented: $viewModel.showExerciseTypeCreationView) {
                try? viewModel.load()
            } content: {
                ExerciseTypeCreationView(exerciseManager: exerciseManager)
            }
            .navigationTitle("Упражнения")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Text("закрыть")
                    }
                }
            }
        }
    }
    
    
    private var exerciseTypesList: some View {
        List {
            ForEach(viewModel.filteredExerciseTypes) { type in
                HStack {
                    Text(type.name)
                    Spacer()
                    VStack {
                        ForEach(type.muscleGroups, id: \.self) { muscleGroup in
                            Text(muscleGroup)
                        }
                    }
                }
                .background(type.isSelected ? .blue : .clear)
                .onTapGesture {
                    viewModel.switchExerciseTypeSelection(byId: type.id)
                }
            }
        }
        .searchable(text: $viewModel.searchQuery, prompt: "Искать упражнение")
    }
    
    private var exerciseTypeCreationButton: some View {
        Button("Создать новое упражнение") {
            viewModel.showExerciseTypeCreationView.toggle()
        }
    }
    
    private var addExerciseToTrainingButton: some View {
        Button("Add to training") {
            viewModel.addSelectedObjects()
            dismiss()
        }
    }
}
