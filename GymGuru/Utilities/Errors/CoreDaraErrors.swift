import Foundation

enum CoreDaraErrors: Error {
    case trainingEntityHasNoId
    
    case exerciseHasNoId
    case exerciseHasNoTypeId
    
    case setHasNoId
    
    case programEntityHasNoId
    case programEntityHasNoName
    
    
    
    case exerciseTypeEntityHasNoId
    case exerciseTypeEntityHasNotAllRequiredProperties
    
    case muscleGroupsConvertingFailed
    
    case fecthFailed
    
    case convertingFailed
}
