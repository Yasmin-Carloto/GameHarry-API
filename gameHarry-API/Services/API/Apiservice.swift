import Foundation

class ApiServices {
    static let shared = ApiServices()
    private let baseURL = "https://wizard-world-api.herokuapp.com/"
    private init() {}
    
    func fetchData<T: Decodable>(from endpoint: Endpoint) async throws -> T {
        // Construir a URL com o endpoint
        guard let url = URL(string: baseURL + endpoint.path) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print("Erro aqui")
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        let decodedData = try decoder.decode(T.self, from: data)
        return decodedData
    }
}


protocol Endpoint {
    var path: String { get }
}

// Exemplo de endpoint
enum WizardWorldEndpoint: Endpoint, CaseIterable {
    case houses
    case potions
    case spells
    case wizards
    
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
