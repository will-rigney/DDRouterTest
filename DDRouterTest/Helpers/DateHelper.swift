import Foundation

class DateHelper {
    static var maxYearOfBirthAllowed: Int {
        return (Calendar.current.component(.year, from: Date()) - Constants.maximumYearDifferenceFromCurrentYear)
    }

    static func validateYearOfBirth(year: String) -> Bool {
        let input = Int(year.description) ?? 0

        if (year.count > Constants.allowedChars) {
            return false
        }

        else if input > maxYearOfBirthAllowed ||
            input < Constants.minimumYearAllowed {
            return false
        }

        else {
            return true
        }
    }
}
