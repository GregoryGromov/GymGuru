import Foundation

extension Array where Element == String {
    func toNSData() -> NSData? {
        return try? NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false) as NSData
    }
    
    static func fromNSData(_ data: NSData) -> [String]? {
        return try? NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSArray.self, NSString.self], from: data as Data) as? [String]
    }
}
