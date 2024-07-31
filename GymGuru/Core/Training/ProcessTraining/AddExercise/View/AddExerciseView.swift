import SwiftUI

struct AddExerciseView: View {
    
    @StateObject var viewModel: AddExerciseViewModel
    
    init(trainingManager: TrainingManager) {
        _viewModel = StateObject(wrappedValue: AddExerciseViewModel(trainingManager: trainingManager))
    }
    
    @State var name = ""
    @State var showExerciseTypeCreationView = false
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.exerciseTypes) { type in
                    HStack {
                        Text(type.name)
                        Spacer()
                        VStack {
                            ForEach(type.muscleGroups, id: \.self) { muscleGroup in
                                Text(muscleGroup)
                            }
                        }
                    }
                }
            }
            
            Button("Добавить кастомные упражнения") {
                do {
                    try ExerciseManager.shared.addExercises(ExerciseType.MOCK2)
                }
                catch {
                    print("Не удалось добавить MOCK2")
                }
            }
            
            Button("Загрузить") {
                do {
                    try viewModel.load()
                }
                catch {
                    print("Не удалось загрузить упражнения")
                }
            }
            
            Button("Удалить") {
                do {
                    try ExerciseManager.shared.deleteAllExerciseTypes()
                }
                catch {
                    print("Не удалось удалить все упражнения")
                }
            }
            
            Button("Создать новое упражнение") {
                showExerciseTypeCreationView.toggle()
            }
        }
        .sheet(isPresented: $showExerciseTypeCreationView) {
            do {
                try viewModel.load()
                print("Упражнения успешно обновлены")
            }
            catch {
                print("Упс")
            }
        } content: {
            ExerciseTypeCreationView()
        }

    }
}

