import Foundation
import CoreData

final class TrainingStorageService: CoreDataService {
    //  MARK: - Adding

    func addTraining(_ training: Training) {
        let trainingEntity = createTrainingEntity(from: training)
        addExercises(to: trainingEntity, from: training.exercises)
        save()
    }
    
    private func addExercises(to trainingEntity: TrainingEntity, from exercises: [Exercise]) {
        for exercise in exercises {
            let exerciseEntity = createExerciseEntity(from: exercise)
            addSets(to: exerciseEntity, from: exercise.sets)
            trainingEntity.addToExercises(exerciseEntity)
        }
    }

    private func createTrainingEntity(from training: Training) -> TrainingEntity {
        let trainingEntity = TrainingEntity(context: context)
        
        trainingEntity.id = training.id
        trainingEntity.dateStart = Int64(training.dateStart)
        trainingEntity.dateEnd = Int64(training.dateEnd)
        trainingEntity.programId = training.programId
        trainingEntity.comment = training.comment
        
        return trainingEntity
    }

    private func createExerciseEntity(from exercise: Exercise) -> ExerciseEntity {
        let exerciseEntity = ExerciseEntity(context: context)
        
        exerciseEntity.id = exercise.id
        exerciseEntity.date = Int64(exercise.date)
        exerciseEntity.typeId = exercise.typeId
        exerciseEntity.comment = exercise.comment
        
        return exerciseEntity
    }

    private func addSets(to exerciseEntity: ExerciseEntity, from sets: [ESet]) {
        for eSet in sets {
            let setEntity = createSetEntity(from: eSet)
            exerciseEntity.addToSets(setEntity)
        }
    }

    private func createSetEntity(from eSet: ESet) -> SetEntity {
        let setEntity = SetEntity(context: context)
        
        setEntity.id = eSet.id
        setEntity.weight = eSet.weight
        setEntity.reps = Int16(eSet.reps)
        
        return setEntity
    }
    
    
    //  MARK: - Fetching
    
    func fetchTrainings() throws -> [Training] {
        guard let trainingEntities = fetch(TrainingEntity.self) else {
            throw CoreDaraErrors.fecthFailed
        }
        return try convertToTrainings(from: trainingEntities)
    }

    private func convertToTrainings(from trainingEntities: [TrainingEntity]) throws -> [Training] {
        var trainings = [Training]()
        
        for trainingEntity in trainingEntities {
            let training = try convertTrainingEntityToTraining(trainingEntity)
            trainings.append(training)
        }
        
        return trainings
    }
    
    
    // MARK: - Deleting
    
    func deleteTraining(byId id: String) {
        let fetchRequest: NSFetchRequest<TrainingEntity> = TrainingEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        do {
            let results = try context.fetch(fetchRequest)
            
            if let trainingEntity = results.first {
                context.delete(trainingEntity)
                try context.save()
                print("DEBUG: Successfully deleted TrainingEntity with id \(id)")
            } else {
                print("DEBUG: No TrainingEntity found with id \(id)")
            }
        } catch {
            print("DEBUG: Failed to delete TrainingEntity: \(error)")
        }
    }

    func deleteAllTrainings() {
        let request = NSFetchRequest<TrainingEntity>(entityName: "TrainingEntity")
        do {
            let fetchedTrainings = try context.fetch(request)
            
            for trainingEntity in fetchedTrainings {
                context.delete(trainingEntity)
                save()
            }
            print("DEBUG: Всё успешно удалено)")
        } catch {
            print("DEBUG: Ошибка при удалении TrainingEntyty: \(error)")
        }
    }

    
    //  MARK: - Converting from Entity to struct-object
    
    func convertTrainingEntityToTraining(_ entity: TrainingEntity) throws -> Training {
        guard let id = entity.id else {
            throw CoreDaraErrors.exerciseTypeEntityHasNoId
        }
        let dateStart = Int(entity.dateStart)
        let dateEnd = Int(entity.dateEnd)
        let programId = entity.programId
        let comment = entity.comment
        
        var exercises = [Exercise]()
        if let exerciseEntities = entity.exercises?.allObjects as? [ExerciseEntity] {
            exercises = try convertExerciseEntitiesToExercises(exerciseEntities)
        }
        
        let training = Training(
            id: id,
            dateStart: dateStart,
            dateEnd: dateEnd,
            exercises: exercises,
            programId: programId,
            comment: comment
        )
        return training
    }
    
    private func convertExerciseEntitiesToExercises(
        _ exerciseEntities: [ExerciseEntity]
    ) throws -> [Exercise] {
        var exercises = [Exercise]()
        
        for exerciseEntity in exerciseEntities {
            try exercises.append(convertExerciseEntityToExercise(exerciseEntity))
        }
        return exercises
    }
    
    private func convertExerciseEntityToExercise(
        _ exerciseEntity: ExerciseEntity
    ) throws -> Exercise {
        guard let exerciseId = exerciseEntity.id else {
            throw CoreDaraErrors.exerciseHasNoId
        }
        guard let exerciseTypeId = exerciseEntity.typeId else {
            throw CoreDaraErrors.exerciseHasNoTypeId
        }
        let exerciseDate = Int(exerciseEntity.date)
        let exerciseComment = exerciseEntity.comment
        
        var sets = [ESet]()
        
        if let setEntities = exerciseEntity.sets?.allObjects as? [SetEntity] {
            sets = try convertSetEntitiesToESets(setEntities)
        }
        
        let exercise = Exercise(
            id: exerciseId,
            date: exerciseDate,
            typeId: exerciseTypeId,
            sets: sets,
            comment: exerciseComment
        )
        return exercise
    }
    
    
    private func convertSetEntitiesToESets(
        _ setEntities: [SetEntity]
    ) throws -> [ESet] {
        var sets = [ESet]()
        
        for setEntity in setEntities {
            guard let setId = setEntity.id else {
                throw CoreDaraErrors.setHasNoId
            }
            let weight = setEntity.weight
            let reps = Int(setEntity.reps)
            
            let exerciseSet = ESet(
                id: setId,
                weight: weight,
                reps: reps
            )
            sets.append(exerciseSet)
        }
        return sets
    }
}
