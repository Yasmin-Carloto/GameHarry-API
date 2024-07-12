//
//  WikiViewmodel.swift
//  gameHarry-API
//
//  Created by Ingryd Cordeiro Duarte on 09/07/24.
//

import Foundation

class WikiViewModel<T: Decodable & Identifiable>: ObservableObject {
    @Published var items: [T] = []
    @Published var potionsFromPotterDB: [ItemData] = []


    func loadData(from endpoint: Endpoint) async {
        do {
            let fetchedItems: [T] = try await ApiServices.shared.fetchData(from: endpoint)
            DispatchQueue.main.async {
                self.items = fetchedItems
            }

            let fetchedPotionsDB: [ItemData] = try await ApiServices.shared.fetchAllPotions()
            DispatchQueue.main.async {
                self.potionsFromPotterDB = fetchedPotionsDB
            }

//            items = try await ApiServices.shared.fetchData(from: endpoint)
//            potionsFromPotterDB = try await ApiServices.shared.fetchAllPotions()
        } catch {
            print("Error fetching data: \(error)")
        }
    }

    func filteredItems(_ searchItem: String) -> [T] {
        items.filter { item in
            searchItem.isEmpty || String(describing: item).localizedCaseInsensitiveContains(searchItem)
        }
    }

    func fetchPotionImage(_ itemName: String) async -> String {
        let slug = convertToSlug(itemName)
        for potion in potionsFromPotterDB {
            if slug == potion.attributes.slug {
                return potion.attributes.image ?? "empty-image-url"
            }
        }
        return "empty-image-url"
    }

    private func convertToSlug(_ name: String) -> String {
        let regex = try! NSRegularExpression(pattern: "(?i)([a-z]+(?:\\s+[a-z]+)*)(?=\\s+em\\s+([a-z]+(?:-[a-z]+)*))", 
                                             options: [])
        let range = NSRange(location: 0, length: name.utf16.count)
        
        var slug = regex.stringByReplacingMatches(in: name, options: [], range: range, withTemplate: "")

        print("Regex antes dos updates: \(slug)")
        slug = slug.replacingOccurrences(of: " ", with: "-")
        slug = slug.replacingOccurrences(of: "'", with: "-")
        return slug.lowercased()
    }

    func imageURL(for potion: Potion) -> String {
        let slug = convertToSlug(potion.name)
        return potionsFromPotterDB.first(where: {$0.attributes.slug == slug})?.attributes.image ?? "empty-image-URL"
    }
}
