import UIKit

extension UITableView {
    func resizeHeader() {
        guard let headerView = tableHeaderView else {
            return
        }
        let size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        if headerView.frame.size.height != size.height {
            headerView.frame.size.height = size.height
            tableHeaderView = headerView
            layoutIfNeeded()
        }
    }
}
