import Foundation

extension URL {
    mutating func append(_ parameters: [String: String]) {
        guard var urlComponents = URLComponents(string: absoluteString) else { return }
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []
        parameters.forEach { queryItems.append(URLQueryItem(name: $0.key, value: $0.value)) }
        urlComponents.queryItems = queryItems
        if let url = urlComponents.url { self = url }
    }
}

extension Data {
    var string: String? { String(data: self, encoding: .utf8) }

    var dictionary: [String: Any]? {
        try? JSONSerialization.jsonObject(with: self, options: .allowFragments) as? [String: Any]
    }
}

extension Dictionary {
    var data: Data? {
        try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
    }
}

extension Encodable {
    /// Converted to Data.
    var data: Data? { try? JSONEncoder().encode(self) }
}

// Operator extensions
func + <K, V> (left: [K: V], right: [K: V]) -> [K: V] {
    var result = [K:V]()
    [left, right].forEach { $0.forEach { (k, v) in result[k] = v } }
    return result
}
