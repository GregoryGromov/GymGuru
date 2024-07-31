import Foundation

extension ExerciseType {
    static let MOCK1 = [
        ExerciseType(
            id: "1",
            name: "Жим лежа",
            muscleGroups: ["Грудь", "Плечи", "Бицепс"],
            isBodyWeight: false
        ),
        ExerciseType(
            id: "2",
            name: "Приседания",
            muscleGroups: ["Ноги", "Ягодицы"],
            isBodyWeight: false
        ),
        ExerciseType(
            id: "3",
            name: "Подтягивания",
            muscleGroups: ["Спина", "Бицепс"],
            isBodyWeight: true
        ),
        ExerciseType(
            id: "4",
            name: "Становая тяга",
            muscleGroups: ["Ноги", "Спина", "Ягодицы"],
            isBodyWeight: false
        ),
        ExerciseType(
            id: "5",
            name: "Отжимания",
            muscleGroups: ["Грудь", "Плечи", "Трицепс"],
            isBodyWeight: true
        )
    ]
    
    static let MOCK2 = [
        ExerciseType(
            id: "6",
            name: "Тяга верхнего блока",
            muscleGroups: ["Спина", "Бицепс"],
            isBodyWeight: false
        ),
        ExerciseType(
            id: "7",
            name: "Подъем на носки (икры)",
            muscleGroups: ["Икры"],
            isBodyWeight: false
        ),
        ExerciseType(
            id: "8",
            name: "Планка",
            muscleGroups: ["Пресс", "Стабилизаторы"],
            isBodyWeight: true
        ),
        ExerciseType(
            id: "9",
            name: "Боковая планка",
            muscleGroups: ["Косые мышцы", "Стабилизаторы"],
            isBodyWeight: true
        ),
        ExerciseType(
            id: "10",
            name: "Скручивания на пресс",
            muscleGroups: ["Пресс"],
            isBodyWeight: true
        )
    ]
}


    

