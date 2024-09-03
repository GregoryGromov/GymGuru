//
//  CoreDataTest.swift
//  GymGuru
//
//  Created by Григорий Громов on 03.09.2024.
//

import SwiftUI

struct CoreDataTest: View {
    
    @State var storageManager = TrainingStorageService()
    
    static let testExercise1 = Exercise(
        id: "dwcw",
        date: 34567,
        typeId: "djnwddsdw",
        sets: [
            ESet(
                id: "dhwueoi",
                weight: 100.0,
                reps: 4
            ),
            ESet(
                id: "dmkped",
                weight: 80.0,
                reps: 8
            )
        ]
    )
    
    static let testExercise2 = Exercise(
        id: "dwdcsdcw",
        date: 3443233567,
        typeId: "djndcsdawddsdw",
        sets: [
            ESet(
                id: "dmkyyped",
                weight: 80.0,
                reps: 8
            )
        ]
    )
    
    
    @State var testTraining = Training(
        id: "eo439oru",
        dateStart: 12345678,
        dateEnd: 3456789,
        exercises: [CoreDataTest.testExercise1, CoreDataTest.testExercise2],
        programId: "testProgramm",
        comment: "Губа"
    )
    
    @State var fetchedTrainings = [Training]()
    
    var body: some View {
        List {
            Section {
                Button("Добавить тренировку в CoreData") {
                    storageManager.addTraining(testTraining)
                }
                
                Button("Загрузить тренировку из CoreData") {
                    do {
                        let trainings = try storageManager.fetchTrainings()
                        fetchedTrainings = trainings
                    }
                    catch {
                        print("DEBUG: Ошибка в месте #1: \(error)")
                    }
                }
                
                Button("Удалить все тренировки из CoreData") {
                    storageManager.deleteAllTrainings()
                }
            }
            
            Section {
                ForEach(fetchedTrainings) { training in
                    VStack {
                        Text(training.id)
                        
                        ForEach(training.exercises) { exercise in
                            HStack {
                                Text(exercise.typeId)
                                Spacer()
                                VStack {
                                    ForEach(exercise.sets) { eSet in
                                        Text("\(eSet.weight) kg x \(eSet.reps)")
                                    }
                                }
                            }
                        }
                        
                    }
                    .swipeActions(allowsFullSwipe: true) {
                        Button() {
                            storageManager.deleteTraining(byId: training.id)
                        } label: {
                            Label("Delete", systemImage: "trash.fill")
                                .tint(.red)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    CoreDataTest()
}
