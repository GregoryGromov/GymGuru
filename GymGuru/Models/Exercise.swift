import Foundation

struct Exercise: Identifiable {
    let id = UUID().uuidString
    let date = Date()
    
    let nameId: String
    
    var sets: [ESet]
    var comment: String?
}
