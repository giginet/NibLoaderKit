import Cocoa

public extension NSView {
    static func view<T: NSView>(withOwner owner: AnyObject?,
                     bundle: NSBundle = NSBundle.mainBundle()) throws -> T {
        let className = String(self)
        return try self.view(fromNibNamed: className, owner: owner, bundle: bundle)
    }

    static func view<T: NSView>(fromNibNamed nibName: String,
                     owner: AnyObject?,
                     bundle: NSBundle = NSBundle.mainBundle()) throws -> T {
        var topLevelObjects: NSArray? = []
        guard bundle.loadNibNamed(nibName, owner: owner, topLevelObjects: &topLevelObjects),
            let objects = topLevelObjects else {
            throw NibLoadingError.NibNotFound
        }

        let views = objects.filter { object in object is NSView }

        if views.count > 1 {
            throw NibLoadingError.MultipleTopLevelObjectsFound
        }

        guard let view = views.first as? T else {
            throw NibLoadingError.TopLevelObjectNotFound
        }
        return view
    }
}
