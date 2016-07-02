import Foundation

enum NibLoadingError: ErrorType {
    case NibNotFound
    case TopLevelObjectNotFound
    case MultipleTopLevelObjectsFound
}