import Cocoa

public extension NSView {
    static func view<T: NSView>(with owner: AnyObject?,
                                bundle: Bundle = Bundle.main) throws -> T {
        let className = String(describing: self)
        return try self.view(from: className, owner: owner, bundle: bundle)
    }

    static func view<T: NSView>(from nibName: String,
                                owner: AnyObject?,
                                bundle: Bundle = Bundle.main) throws -> T {
        var topLevelObjects: NSArray? = []
        guard bundle.loadNibNamed(NSNib.Name(rawValue: nibName), owner: owner, topLevelObjects: &topLevelObjects),
            let objects = topLevelObjects else {
                throw NibLoadingError.nibNotFound
        }

        let views = objects.filter { object in object is NSView }

        if views.count > 1 {
            throw NibLoadingError.multipleTopLevelObjectsFound
        }

        guard let view = views.first as? T else {
            throw NibLoadingError.topLevelObjectNotFound
        }
        return view
    }
}
