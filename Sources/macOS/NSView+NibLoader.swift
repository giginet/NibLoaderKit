import Cocoa

enum NibLoadingError: ErrorType {
    case NibNotFound(String)
    case TopLevelObjectsNotFound
}

extension NSView {
    static func view<T: NSView>(owner owner: AnyObject?) throws -> T {
        let className = String(self).componentsSeparatedByString(".").last! as String
        return try! self.view(fromNibNamed: className, owner: owner)
    }

    static func view<T: NSView>(fromNibNamed nibName: String, owner: AnyObject?) throws -> T {
        let bundle = NSBundle.mainBundle()
        guard let nib = NSNib(nibNamed: nibName, bundle: bundle) else {
            throw NibLoadingError.NibNotFound(nibName)
        }
        var topLevelObjects: NSArray? = []
        nib.instantiateWithOwner(owner, topLevelObjects: &topLevelObjects)

        for topLevelObject in topLevelObjects! {
            if let view = topLevelObject as? T {
                return view
            }
        }
        throw NibLoadingError.TopLevelObjectsNotFound
    }
}
