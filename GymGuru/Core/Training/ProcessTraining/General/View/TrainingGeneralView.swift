import SwiftUI

struct TrainingGeneralView: View {
    
    @StateObject var viewModel: TrainingGeneralViewModel
    
    init(trainingManager: TrainingManager) {
        _viewModel = StateObject(wrappedValue: TrainingGeneralViewModel(trainingManager: trainingManager))
    }
    
    var body: some View {
        VStack {
            stopwatch
            exerciseList
            addExerciseButton
            finishTrainingButton
        }
        .fullScreenCover(isPresented: $viewModel.showAddExerciseView) {
            AddExerciseView(trainingManager: viewModel.trainingManager)
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
    
    private var finishTrainingButton: some View {
        Button("Finish him") {
            viewModel.finishTraining()
        }
    }
    
    private var stopwatch: some View {
        VStack {
            Text("\(viewModel.secondsElapsed) секунд")
                .font(.largeTitle)
                .padding()
            
            HStack {
                Button(action: viewModel.startStopwatch) {
                    Text("Старт")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(DefaultButtonStyle())

                Button(action: viewModel.stopStopwatch) {
                    Text("Стоп")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(DefaultButtonStyle())
                
                Button(action: viewModel.resetStopwatch) {
                    Text("Сброс")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(DefaultButtonStyle())
            }
            .padding()
        }
    }
    
    private func exerciseCell(for exercise: Exercise) -> some View {
        HStack {
            Text(ExerciseManager.shared.getExerciseType(byId: exercise.typeId)) // КОСТЫЛЬ
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

