import Foundation

struct Training: Identifiable {
    let id: String
    
    let dateStart: Int
    var dateEnd: Int
    
    var exercises: [Exercise]
    var programId: String?
    var comment: String?
}
