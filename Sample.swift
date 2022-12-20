
enum MiddlewareAPI: NetworkAPI {
    case addUser
    
    var baseURL: String { "https://..." }
    
    var defaultHeaders: [String : String] { [:] }
    
    var details: NetworkAPIDetails {
        switch self {
        case .addUser: return NetworkAPIDetails(httpMethod: .post, path: "")
        }
    }
}

func addUser() {
    Network<MiddlewareAPI>.request(.addUser, parameters: .dictionary(["name": "Paul"])) { response in
        // Do anything with response.
        // An instance of NetworkResponse with helper methods and properties for response conversion.
    }
}


