import SwiftUI

struct ExerciseTypeCreationView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var name = ""
    @State var isBodyWeight = false
    @State var selectedMuscleGroups = [String]()
    
    let muscleGroups = ["Грудь", "Спина", "Руки", "Плечи"]
    
    var body: some View {
        VStack {
            List {
                Section("Общие данные") {
                    TextField("Введите название", text: $name)
                    Toggle(isOn: $isBodyWeight) {
                        Text("С собственным весом?")
                    }
                    
                }
                
                Section("Выберите группы мышц") {
                    ForEach(muscleGroups, id: \.self) { muscleGroup in
                        HStack {
                            Text(muscleGroup)
                            Spacer()
                        }
                        .background (
                            selectedMuscleGroups.contains(muscleGroup) ?
                                .gray : .white
                        )
                        .onTapGesture {
                            selectedMuscleGroups.append(muscleGroup)
                        }
                    }
                }
                
                Section {
                    Button("Сохрнаить упражнение") {
                        let newExerciseType = ExerciseType(
                            id: UUID().uuidString,
                            name: name,
                            muscleGroups: selectedMuscleGroups,
                            isBodyWeight: isBodyWeight
                        )
                        
                        do {
                            try ExerciseManager.shared.addExercise(newExerciseType)
                        }
                        catch {
                           print("Error saving new exercise type: \(error)")
                        }
                        
                        dismiss()
                    }
                }
            }
        }
    }
}

