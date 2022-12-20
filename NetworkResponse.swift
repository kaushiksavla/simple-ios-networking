import Foundation

public struct NetworkResponse {
    public let data: Data?
    public let statusCode: Int
    public let isSuccessfulRequest: Bool
    public let headerFields: [AnyHashable: Any]?
    public let error: Error?
    
    public init(_ data: Data?,_ urlResponse: URLResponse?,_ error: Error?) {
        self.data = data
        self.error = error
        let httpUrlResponse = urlResponse as? HTTPURLResponse
        statusCode = httpUrlResponse?.statusCode ?? 0
        isSuccessfulRequest = statusCode == 200
        headerFields = httpUrlResponse?.allHeaderFields
    }
    
    // Outputs:
    public var string: String? { data?.string }
    public var stringValue: String { string ?? "" }
    public var dictionary: [String:Any]? { data?.dictionary }
    
    public func decode<T: Codable>(to type: T.Type, strategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T? {
        guard let _data = data else { return nil }
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = strategy
        return try? jsonDecoder.decode(type, from: _data)
    }
    
    public var errorDescription: String { return error?.localizedDescription ?? "" }
}
