import Foundation

struct ExerciseType: Identifiable, Codable {
    let id: String
    
    var name: String
    var muscleGroups: [String]
    var isBodyWeight: Bool
    
    var isSelected: Bool
}
