import Foundation

enum DataStorageError: Error {
    case writingToFileFailed
    case savingToFileFailed
    case readingFromFileFailed

    case invalidPath
    case pathCreationFailed

    case modelContextFailed
    
    case decodingFailed
    case encodingFailed
    case convertingDataFailed
    case JSONSerializingFailed
    
    case unknownError
}

