import SwiftUI

struct TrainingGeneralView: View {
    
    let trainingManager: TrainingManager
    @StateObject var viewModel: TrainingGeneralViewModel
    
    init(trainingManager: TrainingManager) {
        self.trainingManager = trainingManager
        _viewModel = StateObject(wrappedValue: TrainingGeneralViewModel(trainingManager: trainingManager))
    }
    
    var body: some View {
        VStack {
            exerciseList
            addExerciseButton
        }
        .sheet(isPresented: $viewModel.showAddExerciseView) {
            AddExerciseView(trainingManager: trainingManager)
        }
        .sheet(item: $viewModel.selectedExercise) { exercise in
            ExerciseDetailView(trainingManager: viewModel.trainingManager, exercise: exercise)
        }
    }
    
    private var exerciseList: some View {
        List {
            ForEach(viewModel.exercises) { exercise in
                exerciseCell(for: exercise)
                    .onTapGesture {
                        viewModel.selectedExercise = exercise
                        viewModel.showExerciseDetailView = true
                    }
            }
        }
    }
    
    private var addExerciseButton: some View {
        Button("Add exercise") {
            viewModel.showAddExerciseView = true
        }
    }
    
    private func exerciseCell(for exercise: Exercise) -> some View {
        HStack {
            Text(exercise.nameId)
            Spacer()
            VStack {
                ForEach(exercise.sets) { set in
                    HStack {
                        Text("\(set.weight) kg").bold()
                        Text("x \(set.reps)")
                    }
                }
            }
        }
    }
}

