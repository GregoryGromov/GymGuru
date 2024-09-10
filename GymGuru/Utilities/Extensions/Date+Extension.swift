import Foundation

extension Date {
    var toInt: Int {
        return Int(self.timeIntervalSince1970)
    }
}
