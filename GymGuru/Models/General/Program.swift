import Foundation

struct Program: Identifiable {
    let id: String
    var name: String
    var comment: String?
    var exerciseTypeIDs: [String]
    var dateCreation: Int
    var colorThemeID: String?
}
