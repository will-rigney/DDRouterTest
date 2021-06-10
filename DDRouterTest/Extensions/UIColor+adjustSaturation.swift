import Foundation
import UIKit.UIColor

extension UIColor {

    // Reduces color saturation by the defined percentage
    func adjustSaturation(amount: CGFloat) -> UIColor {
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0

        guard getHue(&h, saturation: &s, brightness: &b, alpha: &a) else { return self }

        return UIColor(hue: h,
                       saturation: max(s - amount, 0.0),
                       brightness: b,
                       alpha: a)
    }
    
    // Reduces color opacity by input amount
    func adjustAlpha(amount: CGFloat) -> UIColor {
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0

        guard getHue(&h, saturation: &s, brightness: &b, alpha: &a) else { return self }

        return UIColor(hue: h,
                       saturation: s,
                       brightness: b,
                       alpha: max(a - amount, 0.0))
    }
}
