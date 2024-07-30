import Foundation

enum CoreDaraErrors: Error {
    case exerciseTypeEntityHasNoId
    case exerciseTypeEntityHasNotAllRequiredProperties
    
    case muscleGroupsConvertingFailed
    
    case fecthFailed
}
