import UIKit

public extension UIView {
    class func view<T: UIView>(with owner: AnyObject?,
                               bundle: Bundle = Bundle.main) throws -> T {
        let className = String(describing: self)
        return try self.view(from: className, owner: owner, bundle: bundle)
    }

    class func view<T: UIView>(from nibName: String,
                               owner: AnyObject?,
                               bundle: Bundle = Bundle.main) throws -> T {

        if bundle.path(forResource: nibName, ofType: "nib") == nil {
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
