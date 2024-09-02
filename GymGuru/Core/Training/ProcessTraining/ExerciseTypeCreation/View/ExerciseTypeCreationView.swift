import SwiftUI

struct ExerciseTypeCreationView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = ExerciseTypeCreationViewModel()
   
    var body: some View {
        VStack {
            List {
                mainInfoSection
                
                saveButtonSection
                
                muscleGroupSelectionSection
            }
        }
    }
    
    
    var mainInfoSection: some View {
        Section("Общие данные") {
            TextField("Введите название", text: $viewModel.name)
            Toggle(isOn: $viewModel.isBodyWeight) {
                Text("С собственным весом")
            }
        }
    }
    
    
    var muscleGroupSelectionSection: some View {
        Section("Выберите группы мышц") {
            ForEach(viewModel.muscleGroups, id: \.self) { muscleGroup in
                HStack {
                    Text(muscleGroup)
                    Spacer()
                }
                .background (
                    viewModel.isSelected(muscleGroup: muscleGroup) ?
                        .gray : .white
                )
                .onTapGesture {
                    viewModel.switchSelection(muscleGroup: muscleGroup)
                }
            }
        }
    }
    
    
    var saveButtonSection: some View {
        Section {
            Button("Сохранить упражнение") {
                do {
                    try viewModel.save()
                }
                catch {
                    print("DEBUG: Ошибка сохранения нового ExerciseType")
                }
                dismiss()
            }
        }
    }
}

