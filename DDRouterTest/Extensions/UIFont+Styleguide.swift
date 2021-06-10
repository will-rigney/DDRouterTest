import Foundation
import UIKit.UIFont

extension UIFont {

    // style enum
    private enum Style: String {
        case h1
        case h2
        case h3
        case h4
        case h5
        case h6
        case primaryButton
        case selectionButton
        case largeText
        case largeTextBold
        case mediumText
        case mediumTextBold
        case normalText
        case normalTextBold
        case smallText
        case smallTextBold
        case captionText
    }

    class var h1: UIFont {
        return font(style: .h1)
    }

    class var h2: UIFont {
        return font(style: .h2)
    }

    class var h3: UIFont {
        return font(style: .h3)
    }

    class var h4: UIFont {
        return font(style: .h4)
    }

    class var h5: UIFont {
        return font(style: .h5)
    }

    class var h6: UIFont {
        return font(style: .h6)
    }

    class var primaryButton: UIFont {
        return font(style: .primaryButton)
    }

    class var selectionButton: UIFont {
        return font(style: .selectionButton)
    }

    class var largeText: UIFont {
        return font(style: .largeText)
    }

    class var largeTextBold: UIFont {
        return font(style: .largeTextBold)
    }

    class var mediumText: UIFont {
        return font(style: .mediumText)
    }

    class var mediumTextBold: UIFont {
        return font(style: .mediumTextBold)
    }

    class var normalText: UIFont {
        return font(style: .normalText)
    }

    class var normalTextBold: UIFont {
        return font(style: .normalTextBold)
    }

    class var smallText: UIFont {
        return font(style: .smallText)
    }

    class var smallTextBold: UIFont {
        return font(style: .smallTextBold)
    }

    class var captionText: UIFont {
        return font(style: .captionText)
    }

    // this library is growing - now we have an error type
    enum FontError: Error {
        case invalidWeight
        case invalidName
        case invalidSize
    }

    // add exceptions to max font size style
    private static let maxFontSizeStyleExceptions: [Style] = [.h1]

    // Used to limit the size of content-specific text
    private static let maxFontSize: CGFloat = 40

    // Used to limit the size of design-specific text
    private static let maxDisplayFontSize: CGFloat = 80

    // if no name is included we default to the system font
    private struct FontDescription: Decodable {
        let fontSize: CGFloat
        let fontName: String?
        let lineHeight: CGFloat?
        let fontWeight: Weight
    }

    private typealias StyleDictionary = [TextStyle.RawValue: FontDescription]

    private static var styleDictionary: StyleDictionary? = {

        let decoder = PropertyListDecoder()

        guard
            let url = Bundle.main.url(forResource: "Fonts", withExtension: "plist"),
            let data = try? Data(contentsOf: url),
            let styleDictionary = try? decoder.decode(StyleDictionary.self, from: data) else {

            return nil
        }

        return styleDictionary
    }()

    private static func font(style: Style) -> UIFont {
        guard let fontDescription = styleDictionary?[style.rawValue] else {
            // if font not defined use default system font
            return UIFont.systemFont(ofSize: 11, weight: .medium)
        }

        let unscaledFont: UIFont

        if
            let fontName = fontDescription.fontName,
            let font = UIFont(
                name: fontName,
                size: fontDescription.fontSize) {

            unscaledFont = font
        }
        else {
            unscaledFont = UIFont.systemFont(
                ofSize: fontDescription.fontSize,
                weight: fontDescription.fontWeight)
        }

        let uiFontMetrics = UIFontMetrics(forTextStyle: .title1)

        let maximumPointSize = maxFontSizeStyleExceptions.contains(style)
            ? maxDisplayFontSize
            : maxFontSize

        return uiFontMetrics.scaledFont(
            for: unscaledFont,
            maximumPointSize: maximumPointSize)
    }
}

extension UIFont.Weight: Decodable {
    enum WeightKeys: String {
        case ultraLight
        case thin
        case light
        case regular
        case medium
        case semibold
        case bold
        case heavy

        var weight: UIFont.Weight {
            switch self {
            case .ultraLight: return .ultraLight
            case .thin: return .thin
            case .light: return .light
            case .regular: return .regular
            case .medium: return .medium
            case .semibold: return .semibold
            case .bold: return .bold
            case .heavy: return .heavy
            }
        }
    }

    public init(from decoder: Decoder) throws {
        let rawValue = try decoder.singleValueContainer().decode(String.self)
        guard let weight = WeightKeys(rawValue: rawValue)?.weight else {
            throw UIFont.FontError.invalidWeight
        }
        self = weight
    }
}
