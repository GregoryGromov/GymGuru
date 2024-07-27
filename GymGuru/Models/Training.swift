import Foundation

struct Training {
    let id = UUID().uuidString
    
    let dateStart = Date()
    var dateEnd: Date?
    
    var exercises: [Exercise]
    var programId: String
    var comment: String?
}
