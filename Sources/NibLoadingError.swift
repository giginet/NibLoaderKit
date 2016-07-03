import Foundation

public enum NibLoadingError: ErrorType {
    case NibNotFound
    case TopLevelObjectNotFound
    case MultipleTopLevelObjectsFound
}
