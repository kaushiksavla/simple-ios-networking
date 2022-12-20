import Foundation

public struct Network<T: NetworkAPI> {
    
    private init() { }
    
    public enum ParametersType {
        case query([String: String]), dictionary([String: Any]), body(Data?), none
    }
    
    public static func request(_ api: T,
                               parameters: ParametersType = .none,
                               additionalHeaders: [String: String] = [:],
                               completion: @escaping (NetworkResponse) -> ()) {
        guard var url = URL(string: api.baseURL + api.details.path) else { return }
        if case let .query(params) = parameters { url.append(params) }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = api.details.httpMethod
        
        switch parameters {
        case .dictionary(let dictionary):
            urlRequest.httpBody = dictionary.data
        case .body(let data): urlRequest.httpBody = data
        default: break
        }
        
        (api.defaultHeaders + additionalHeaders + api.details.contentType).forEach {
            urlRequest.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        config.urlCache = nil
        config.timeoutIntervalForRequest = api.details.timeoutInterval
        
        let urlSession = URLSession(configuration: config, delegate: nil, delegateQueue: nil)
        urlSession.dataTask(with: urlRequest) { (data, response, error) in
            let networkResponse = NetworkResponse(data, response, error)
            completion(networkResponse)
        }.resume()
        
        urlSession.finishTasksAndInvalidate()
    }
    
}
