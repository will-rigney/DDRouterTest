import Foundation

struct InternetConnectionError: Error {}

enum VerificationCodeError: Error {
    case incorrectInput // Used to show inline red error text
    case tooManyRequests
}
