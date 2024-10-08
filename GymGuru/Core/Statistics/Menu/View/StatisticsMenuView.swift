//
//  StatisticsMenuView.swift
//  GymGuru
//
//  Created by Григорий Громов on 03.09.2024.
//

import SwiftUI

struct StatisticsMenuView: View {
    
    @StateObject var viewModel: StatisticsMenuViewModel
    let exerciseManager: ExerciseManager
    
    init(dataManager: DataManager, exerciseManager: ExerciseManager) {
        _viewModel = StateObject(wrappedValue: StatisticsMenuViewModel(dataManager: dataManager))
        self.exerciseManager = exerciseManager
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.trainings) { training in
                    VStack {
                        Text(training.id)
                        
                        ForEach(training.exercises) { exercise in
                            HStack {
                                Text(exerciseManager.getExerciseTypeName(byId: exercise.typeId))
                                Spacer()
                                VStack {
                                    ForEach(exercise.sets) { eSet in
                                        Text("\(eSet.weight) kg x \(eSet.reps)")
                                    }
                                }
                            }
                        }
                        
                    }
                }
            }
            .navigationTitle("Все тренировки")
        }
    }
}


