import UIKit

extension UITextField {
    /** Adapted from https://stackoverflow.com/questions/38133853/how-to-add-a-return-key-on-a-decimal-pad-in-swift
    */
    func addDoneToolbar(onDone: (target: Any, action: Selector)? = nil) {
        let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))
        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(
                barButtonSystemItem: .done,
                target: onDone.target,
                action: onDone.action)
        ]
        toolbar.sizeToFit()
        inputAccessoryView = toolbar
    }

    /** Dismiss keyboard when Done button is tapped
     */
    @objc func doneButtonTapped() {
        endEditing(true)
    }
}
