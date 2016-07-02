import UIKit

extension UIView {
    static func view<T: UIView>(owner owner: AnyObject?,
                     bundle: NSBundle = NSBundle.mainBundle()) throws -> T {
        let className = String(self)
        return try! self.view(fromNibNamed: className, owner: owner, bundle: bundle)
    }
    
    static func view<T: UIView>(fromNibNamed nibName: String,
                     owner: AnyObject?,
                     bundle: NSBundle = NSBundle.mainBundle()) throws -> T {
        
        guard let _ = bundle.pathForResource(nibName, ofType: "nib") else {
            throw NibLoadingError.NibNotFound
        }
        
        let objects = bundle.loadNibNamed(nibName, owner: owner, options: nil)
        
        let views = objects.filter { object in object is UIView }
    
        if views.count > 1 {
            throw NibLoadingError.MultipleTopLevelObjectsFound
        }
        
        guard let view = views.first as? T else {
            throw NibLoadingError.TopLevelObjectNotFound
        }
        return view
    }
}
