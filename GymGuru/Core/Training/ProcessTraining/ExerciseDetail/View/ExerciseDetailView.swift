//
//  ExerciseDetailView.swift
//  GymGuru
//
//  Created by Григорий Громов on 28.07.2024.
//

import SwiftUI

struct ExerciseDetailView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: ExerciseDetailViewModel
    
    init(trainingManager: TrainingManager, exercise: Exercise) {
        _viewModel = StateObject(wrappedValue:
            ExerciseDetailViewModel(
                trainingManager: trainingManager,
                exercise: exercise
            )
        )
    }
    
    var body: some View {
        VStack {
            Text(viewModel.exercise.nameId).font(.title).bold()
            
            Button("Add set") {
                viewModel.addSet(weight: 100, reps: 3)
            }
            
            Button("Save") {
                viewModel.save()
                dismiss()
            }
        }
    }
}


