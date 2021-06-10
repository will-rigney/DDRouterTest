import UIKit

extension UITextView {
    /** Adapted from https://stackoverflow.com/questions/41387549/how-to-align-text-inside-textview-vertically
    */

    func centerVerticalText() {
        textAlignment = .center
        let fitSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fitSize)
        let calculate = (bounds.size.height - size.height * zoomScale) / 2
        let offset = max(1, calculate)
        contentOffset.y = -offset
    }
}
