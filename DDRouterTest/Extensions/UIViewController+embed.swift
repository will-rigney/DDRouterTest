import UIKit

// useful and good
// todo: doc
extension UIViewController {

    func embed(_ vc: UIViewController) {
        view.subviews.forEach { $0.removeFromSuperview() }
        children.forEach { $0.removeFromParent() }
        addChild(vc)
        view.addSubview(vc.view)
        vc.didMove(toParent: self)
    }

    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
