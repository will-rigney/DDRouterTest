import Foundation
import DDRouter

struct ResponseModel: Decodable {
    let id: Int
    let title: String
//    let author: String
}

struct ErrorModel: APIErrorModelProtocol, Decodable {
    let message: String
}

enum TestEndpoint {
    case random
}


extension TestEndpoint: EndpointType {

    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com")!
    }

    var path: String {
        switch self {
        case .random:
            return "/todos/1"
        }
    }

    var query: [String : String] {
        return [:]
    }

    var method: HTTPMethod {
        switch self {
        case .random:
            return .get
        }
    }

    var task: HTTPTask {
        switch self {
        case .random:
            return .request
        }
    }

    var headers: HTTPHeaders? {
        return [:]
    }
}
