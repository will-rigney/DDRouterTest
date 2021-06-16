import UIKit

extension UITableViewCell {
    class var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewHeaderFooterView {
    class var identifier: String {
        return String(describing: self)
    }
}

