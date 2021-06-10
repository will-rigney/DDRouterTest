import DDRouter

class HTTPHelper {
    static func getAuthHeaders(token: String) -> HTTPHeaders {
        var headers = HTTPHeaders()
        headers["Authorization"] = "Bearer \(token)"
        return headers
    }
}
