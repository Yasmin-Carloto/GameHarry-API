import Foundation


class ApiServices {
    static let shared = ApiServices()
    private init() {}
    
    func fetchData<T: Decodable>(from endpoint: Endpoint) async throws -> T {
        // Construir a URL com o endpoint
        guard let url = URL(string: endpoint.baseURL + endpoint.path) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        let decodedData = try decoder.decode(T.self, from: data)
        return decodedData
    }
    
    func fetchAllPotions() async throws -> [ItemData] {
        var allPotions: [ItemData] = []
        var currentPage: Int = 1
        var totalPages: Int = 2
        
        repeat {
            let endpoint = PotterDBEndpoint.potions(page: currentPage)
            let result: PotterDB = try await fetchData(from: endpoint)
            allPotions.append(contentsOf: result.data)

            currentPage += 1
        } while currentPage <= totalPages
        
        return allPotions
    }
}


protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
}

// Exemplo de endpoint
enum WizardWorldEndpoint: Endpoint, CaseIterable {
    case houses
    case potions
    case spells
    case wizards
    
    var baseURL: String {
        return "https://wizard-world-api.herokuapp.com/"
    }
    
    var path: String {
        switch self {
        case .houses:
            return "houses"
        case .potions:
            return "elixirs"
        case .spells:
            return "spells"
        case .wizards:
            return "wizards"
        }
    }
}

enum PotterDBEndpoint: Endpoint {
    case potions(page: Int)
    case potion(named:String)

    var baseURL: String {
        return "https://api.potterdb.com/v1/"
    }
    
    var path: String {
        switch self {
        case .potions(let page):
            return "potions?page[number]=\(page)"
        case .potion(let name):
            return "potions/\(name)"
        }
    }
}



//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//
//                          Código Magno
//
//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-




/*
import Foundation

struct Server {
    static let potterDB: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.potterdb.com"
        components.path = "/v1"
        return components
    }()
    
    static let wizardWorld: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "wizard-world-api.herokuapp.com"
        return components
    }()
}

protocol RequestTemplate {
    associatedtype Response
    
    var url: URL? { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var headers: [String: String] { get }
    var queryItems: [URLQueryItem] { get }
    var data: Data? { get }
    
    func decode(_ data: Data) throws -> Response
}

extension RequestTemplate {
    var headers: [String: String] { [:] }
    var queryItems: [URLQueryItem] { [] }
    var data: Data? { nil }
}

extension RequestTemplate where Self: Encodable {
    var data: Data? { try? JSONEncoder().encode(self) }
}

extension RequestTemplate where Response: Decodable {
    func decode(_ data: Data) throws -> Response {
        return try JSONDecoder().decode(Response.self, from: data)
    }
}

enum NetworkServiceError: String, Error, CaseIterable {
    case urlError = "A URL inserida é inválida"
    case unauthorized = "Sua sessão expirou.\nEfetue o login novamente."
    case dataError = "Verifique os dados informados."
    case clientError = "Verifique os dados informados e a sua conexão com a internet. Caso o error persista entre em contato com o nosso suporte."
    case serverError = "Parece que estamos passando por manutenção nos servidores.\nTente novamente mais tarde."
    case unknownError = "Um erro inesperado ocorreu.\nEntre em contato com o nosso suporte ou tente novamente mais tarde."
}

enum HTTPMethod: String {
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case connect = "CONNECT"
    case options = "OPTIONS"
    case trace = "TRACE"
    case patch = "PATCH"
}

protocol NetworkServiceInterface {
    func request<Request: RequestTemplate>(
        _ request: Request,
        using session: URLSession,
        completion: @escaping (Result<Request.Response, NetworkServiceError>) -> Void)
    
    func request<Request: RequestTemplate>(
        _ request: Request,
        using session: URLSession) async -> (Result<Request.Response, NetworkServiceError>)
}
class NetworkService: NetworkServiceInterface {
    static let shared: NetworkService = NetworkService()
    
    func request<Request: RequestTemplate>(
        _ request: Request,
        using session: URLSession = URLSession.shared,
        completion: @escaping (Result<Request.Response, NetworkServiceError>) -> Void) {
            guard let url = request.url else {
                return completion(.failure(NetworkServiceError.unknownError))
            }
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = request.method.rawValue
            urlRequest.httpBody = request.data
            urlRequest.allHTTPHeaderFields = request.headers
            
            session.dataTask(with: urlRequest) { data, response, error in
                DispatchQueue.main.async {
                    if error != nil {
                        return completion(.failure(NetworkServiceError.unknownError))
                    }
                    
                    guard let httpResponse = response as? HTTPURLResponse else {
                        return completion(.failure(NetworkServiceError.unknownError))
                    }
                    
                    switch httpResponse.statusCode {
                    case 401:
                        return completion(.failure(NetworkServiceError.unauthorized))
                    case 400...499:
                        
                        return completion(.failure(NetworkServiceError.clientError))
                    case 500...599:
                        return completion(.failure(NetworkServiceError.serverError))
                    default:
                        break
                    }
                    
                    guard let data = data else {
                        return completion(.failure(NetworkServiceError.unknownError))
                    }
                    
                    if Request.Response.self != Data.self {
                        do {
                            try completion(.success(request.decode(data)))
                        } catch {
                            completion(.failure(NetworkServiceError.unknownError))
                        }
                    } else {
                        completion(.success(data as! Request.Response))
                    }
                }
            }.resume()
        }
    @MainActor
    func request<Request>(_ request: Request,
                          using session: URLSession) async -> (Result<Request.Response, NetworkServiceError>) where Request : RequestTemplate {
        guard let url = request.url else {
            return .failure(NetworkServiceError.unknownError)
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.data
        urlRequest.allHTTPHeaderFields = request.headers
        
        do {
            let result = try await session.data(for: urlRequest)
            let data = result.0
            let response = result.1
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure(NetworkServiceError.unknownError)
            }
            
            switch httpResponse.statusCode {
            case 401:
                return .failure(NetworkServiceError.unauthorized)
            case 400...499:
                return .failure(NetworkServiceError.clientError)
            case 500...599:
                return .failure(NetworkServiceError.serverError)
            default:
                break
            }
            
            if Request.Response.self != Data.self {
                return .success(try request.decode(data))
            } else {
                return .success(data as! Request.Response)
            }
            
        } catch {
            return .failure(NetworkServiceError.unknownError)
        }
        
    }
    
}


struct PotionEndpoint {
    
    typealias ResponseWizardWorld = [Potion]
    typealias ResponsePotterDB = PotterDB
    
    struct RequestPotterDB {}
    
    struct RequestWizardWorld {}
    
}

extension PotionEndpoint.RequestPotterDB: RequestTemplate {
    
    typealias Response = PotionEndpoint.ResponsePotterDB
    
    var url: URL? {
        var components = Server.potterDB
        components.path += self.path
        return components.url
    }

    var method: HTTPMethod { .get }

    var path: String { "/potions" }

    var headers: [String: String] { [
        "Content-Type": "application/json",
    ] }

}


extension PotionEndpoint.RequestWizardWorld: RequestTemplate {
    
    typealias Response = PotionEndpoint.ResponseWizardWorld
    
    var url: URL? {
        var components = Server.wizardWorld
        components.path += self.path
        return components.url
    }

    var method: HTTPMethod { .get }

    var path: String { "/elixirs" }

    var headers: [String: String] { [
        "Content-Type": "application/json",
    ] }
    
}

*/
