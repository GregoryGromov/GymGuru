import SwiftUI

struct ExerciseDetailView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: ExerciseDetailViewModel
    
    let exerciseManager: ExerciseManager
    
    init(trainingManager: TrainingManager, exercise: Exercise, exerciseManager: ExerciseManager) {
        _viewModel = StateObject(wrappedValue:
            ExerciseDetailViewModel(
                trainingManager: trainingManager,
                exercise: exercise
            )
        )
        self.exerciseManager = exerciseManager
    }
    
    var body: some View {
        VStack {
            Text(exerciseManager.getExerciseTypeName(byId: viewModel.exercise.typeId)) // КОСТЫЛЬ
                .font(.title)
                .bold()
            setsList
            
            setAdding
            addButton
            saveButton
        }
    }
    
    private var setAdding: some View {
        HStack {
            TextField("Weight", text: $viewModel.weight)
                .keyboardType(.numberPad)
            TextField("Amount", text: $viewModel.reps)
        }
    }
    
    private var setsList: some View {
        List {
            ForEach(viewModel.exercise.sets) { set in
                setCell(for: set)
            }
        }
    }
    
    private func setCell(for set: ESet) -> some View {
        HStack {
            Text("\(set.weight) kg").bold()
            Spacer()
            Text("x \(set.reps)")
        }
        .background(
            viewModel.selectedSetId == set.id ?
                .gray :
                .white
        )
        .swipeActions(allowsFullSwipe: true) {
            Button() {
                viewModel.deleteSet(byId: set.id)
            } label: {
                Label("Delete", systemImage: "trash.fill")
                    .tint(.red)
            }
        }
        .onTapGesture {
            viewModel.switchSetSelection(byId: set.id)
        }
    }
    
    private var addButton: some View {
        Button("Add set") {
            if let selectedSetId = viewModel.selectedSetId {
                viewModel.updateSet(byId: selectedSetId, weight: Float(viewModel.weight) ?? 22, reps: Int(viewModel.reps) ?? 8)
                viewModel.selectedSetId = nil
            } else {
                viewModel.addSet(weight: Float(viewModel.weight) ?? 22, reps: Int(viewModel.reps) ?? 8)
            }
        }
    }
    
    private var saveButton: some View {
        Button("Save") {
            viewModel.save()
            dismiss()
        }
    }
}


