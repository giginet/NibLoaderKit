import Foundation

public enum NibLoadingError: Error {
    case nibNotFound
    case topLevelObjectNotFound
    case multipleTopLevelObjectsFound
}
