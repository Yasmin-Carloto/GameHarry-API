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
