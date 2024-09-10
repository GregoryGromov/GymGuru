import Foundation

final class MOCKDataService: TrainingManageable {
    
    static let setsPool = [
        ESet(id: UUID().uuidString, weight: 0.0, reps: 8),
        ESet(id: UUID().uuidString, weight: 10.0, reps: 8),
        ESet(id: UUID().uuidString, weight: 20.0, reps: 8),
        ESet(id: UUID().uuidString, weight: 30.0, reps: 8),
        ESet(id: UUID().uuidString, weight: 40.0, reps: 8),
        ESet(id: UUID().uuidString, weight: 50.0, reps: 8),
        ESet(id: UUID().uuidString, weight: 60.0, reps: 8),
        ESet(id: UUID().uuidString, weight: 70.0, reps: 8)
    ]
    
    static let exerciseTypePool = [
        "Подтягивания",
        "Отжимания",
        "Жим лежа",
        "Присед"
    ]
    
    var trainings = [
        "trainingID1" : Training(
            id: "trainingID1",
            dateStart: Date().toInt,
            dateEnd: 12345,
            exercises: [
                Exercise(
                    id: UUID().uuidString,
                    date: Date().toInt,
                    typeId: exerciseTypePool[0],
                    sets: [
                        setsPool[0], setsPool[3], setsPool[4], setsPool[2]
                    ]
                ),
                Exercise(
                    id: UUID().uuidString,
                    date: Date().toInt,
                    typeId: exerciseTypePool[1],
                    sets: [
                        setsPool[2]
                    ]
                )
            ]
        ),
        "trainingID2" : Training(
            id: UUID().uuidString,
            dateStart: Date().toInt - 100000,
            dateEnd: 12345,
            exercises: [
                Exercise(
                    id: UUID().uuidString,
                    date: Date().toInt - 100000,
                    typeId: exerciseTypePool[0],
                    sets: [
                        setsPool[0], setsPool[3], setsPool[4], setsPool[5]
                    ]
                ),
            ]
        ),
        "trainingID3" : Training(
            id: UUID().uuidString,
            dateStart: Date().toInt - 200000,
            dateEnd: 12345,
            exercises: [
                Exercise(
                    id: UUID().uuidString,
                    date: Date().toInt - 200000,
                    typeId: exerciseTypePool[0],
                    sets: [
                        setsPool[2]
                    ]
                ),
                Exercise(
                    id: UUID().uuidString,
                    date: Date().toInt - 200000,
                    typeId: exerciseTypePool[1],
                    sets: [
                        setsPool[0], setsPool[7], setsPool[4], setsPool[2]
                    ]
                )
            ]
        ),
        "trainingID4" : Training(
            id: UUID().uuidString,
            dateStart: Date().toInt - 4000000,
            dateEnd: 12345,
            exercises: [
                Exercise(
                    id: UUID().uuidString,
                    date: Date().toInt - 4000000,
                    typeId: exerciseTypePool[0],
                    sets: [
                        setsPool[2]
                    ]
                ),
                Exercise(
                    id: UUID().uuidString,
                    date: Date().toInt - 4000000,
                    typeId: exerciseTypePool[1],
                    sets: [
                        setsPool[3], setsPool[7], setsPool[4], setsPool[2]
                    ]
                )
            ]
        ),
        "trainingID5" : Training(
            id: UUID().uuidString,
            dateStart: Date().toInt - 8000000,
            dateEnd: 12345,
            exercises: [
                Exercise(
                    id: UUID().uuidString,
                    date: Date().toInt - 8000000,
                    typeId: exerciseTypePool[0],
                    sets: [
                        setsPool[1]
                    ]
                ),
                Exercise(
                    id: UUID().uuidString,
                    date: Date().toInt - 8000000,
                    typeId: exerciseTypePool[1],
                    sets: [
                        setsPool[0], setsPool[7], setsPool[4], setsPool[2]
                    ]
                )
            ]
        )
    ]
    
    func deleteTraining(withId id: String) {}
}
