import SwiftUI

struct TrainingGeneralView: View {
    @StateObject var viewModel: TrainingGeneralViewModel
    
    let exerciseManager: ExerciseManager
    
    init(
        mode: TrainingStartMode,
        program: Program? = nil,
        dataManager: DataManager,
        stateService: TrainingStateService,
        exerciseManager: ExerciseManager
    ) {
        _viewModel = StateObject(
            wrappedValue:
                TrainingGeneralViewModel(
                    mode: mode,
                    program: program,
                    dataManager: dataManager,
                    stateService: stateService, 
                    exerciseManager: exerciseManager
                )
            )
        self.exerciseManager = exerciseManager
    }
    
    var body: some View {
        VStack {
            stopwatch
            exerciseList
            addExerciseButton
            finishTrainingButton
        }
        .fullScreenCover(isPresented: $viewModel.showAddExerciseView) {
            AddExerciseView(
                addingMode: .exercise,
                exerciseStoringManager: viewModel.trainingManager,
                exerciseManager: exerciseManager
            )
        }
        .sheet(item: $viewModel.selectedExercise) { exercise in
            ExerciseDetailView(
                trainingManager: viewModel.trainingManager,
                exercise: exercise,
                exerciseManager: exerciseManager)
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
    
    private var finishTrainingButton: some View {
        Button("Finish") {
            viewModel.finishTraining()
        }
    }
    
    private var stopwatch: some View {
        VStack {
            Text("\(viewModel.secondsElapsed) секунд")
                .font(.largeTitle)
                .padding()
        }
    }
    
    private func exerciseCell(for exercise: Exercise) -> some View {
        HStack {
            Text(exerciseManager.getExerciseTypeName(byId: exercise.typeId))
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
        .swipeActions(allowsFullSwipe: true) {
            Button() {
                viewModel.deleteExercise(byId: exercise.id)
            } label: {
                Label("Delete", systemImage: "trash.fill")
                    .tint(.red)
            }
        }
    }
}

