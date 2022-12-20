import Foundation

public protocol NetworkAPI {
    var baseURL: String { get }
    var defaultHeaders: [String: String] { get }
    var details: NetworkAPIDetails { get }
}

public enum HttpMethod: String {
    case post, get, put, patch, delete
}

public enum ContentType: String {
    case urlEncoded = "application/x-www-form-urlencoded"
    case json = "application/json"
}

public struct NetworkAPIDetails {
    
    public let httpMethod, path: String
    public let timeoutInterval: TimeInterval
    public let contentType: [String: String]
    
    public init(httpMethod: HttpMethod,
                path: String,
                timeout: TimeInterval = 60,
                contentType: ContentType = .json) {
        self.httpMethod = httpMethod.rawValue.uppercased()
        self.path = path
        timeoutInterval = timeout
        self.contentType = ["Content-Type": contentType.rawValue]
    }
    
}
