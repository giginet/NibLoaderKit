import UIKit

public extension UIView {
    static func view<T: UIView>(withOwner owner: AnyObject?,
                     bundle: Bundle = Bundle.main) throws -> T {
        let className = String(describing: self)
        return try self.view(from: className, owner: owner, bundle: bundle)
    }

    @available(*, renamed: "view(from:owner:bundle:)")
    static func view<T: UIView>(fromNibNamed nibName: String,
                     owner: AnyObject?,
                     bundle: Bundle = Bundle.main) throws -> T {
        fatalError()
    }
    
    static func view<T: UIView>(from nibName: String,
                     owner: AnyObject?,
                     bundle: Bundle = Bundle.main) throws -> T {

        guard let _ = bundle.path(forResource: nibName, ofType: "nib") else {
            throw NibLoadingError.nibNotFound
        }

        let objects = bundle.loadNibNamed(nibName, owner: owner, options: nil) as [AnyObject]?
        let views = objects?.filter { object in object is UIView }

        if let views = views, views.count > 1 {
            throw NibLoadingError.multipleTopLevelObjectsFound
        }

        guard let view = views?.first as? T else {
            throw NibLoadingError.topLevelObjectNotFound
        }
        return view
    }
}
