import Foundation

struct Training {
    let id = UUID().uuidString
    
    let dateStart: Int
    var dateEnd: Int
    
    var exercises: [Exercise]
    var programId: String
    var comment: String?
}
