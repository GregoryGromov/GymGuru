import Foundation

struct Exercise: Identifiable, Codable {
    let id: String
    let date: Int
    
    let nameId: String
    
    var sets: [ESet]
    var comment: String?
}
