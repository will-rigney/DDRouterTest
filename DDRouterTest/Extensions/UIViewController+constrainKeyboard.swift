import Foundation

import UIKit

protocol ConstrainKeyboard: UIViewController {
    func getKeyboardConstraintConstant(
        notification: Notification,
        defaultConstant: CGFloat,
        keyboardPadding: CGFloat) -> CGFloat

    func addKeyboardObserver(selector: Selector)
}

extension ConstrainKeyboard {

    func getKeyboardConstraintConstant(
        notification: Notification,
        defaultConstant: CGFloat,
        keyboardPadding: CGFloat) -> CGFloat {

        guard
            let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey],
            let keyboardHeight = (keyboardFrame as? NSValue)?.cgRectValue.height else {

            return defaultConstant
        }

        let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification

        return isKeyboardShowing
            ? keyboardHeight + keyboardPadding
            : defaultConstant
    }

    func addKeyboardObserver(selector: Selector) {
        // Add observers to handle keyboard show/hide notifications.
        NotificationCenter.default.addObserver(
            self,
            selector: selector,
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: selector,
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
    }
}
