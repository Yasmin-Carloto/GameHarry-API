//
//  WikiPage.swift
//  gameHarry-API
//
//  Created by User on 05/07/24.
//
import SwiftUI

struct WikiPage<T: Decodable & Identifiable>: View {
    var endpoint: Endpoint

    @ObservedObject var viewModel: WikiViewModel
    @State private var items: [T] = []
    @State private var searchItem: String = ""
    @State private var potions: [Data] = []
    @State private var potionsFromPotterDB: [Data] = []
    // Dicionário para armazenar URLs das imagens das poções


    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                headerView
                searchBar
                itemsGridView
            }
        }
        .task {
            await loadData()
        }
        .foregroundStyle(.roseEbony)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.horizontal, 12)
        .paperTexture()
    }

    // MARK: - Componentização
    private var headerView: some View {
        Text(endpoint.path.capitalized)
            .font(.cinzelDecorative(.bold))
            .padding(2)
    }

    private var searchBar: some View {
        SearchBar(text: $searchItem, placeholder: "Search \(endpoint.path.lowercased())")
            .padding(3)
    }

    private var itemsGridView: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                ForEach(filteredItems) { item in
                    returnCard(item)
                }
            }
        }
    }

    // MARK: - Variáveis Computadas

    private var filteredItems: [T] {
        items.filter { item in
            searchItem.isEmpty || String(describing: item).localizedCaseInsensitiveContains(searchItem)
        }
    }
    // MARK: - Métodos Auxiliares
    private func returnCard(_ item: T) -> some View {
        if let house = item as? House {
            return AnyView(CardView(cardImage: "globe", name: house.name, subname: house.founder))
        } else if let potion = item as? Potion {
            return AnyView(PotionCardView(potion: potion, imageURL: {
                let convertedName = convertToSlug(potion.name)
                var imageString = ""
                potionsFromPotterDB.forEach { data in
                    print("\(data.attributes.slug) == \(convertedName) ?")
                    if data.attributes.slug == convertedName {
                        imageString = data.attributes.image ?? ""
                    }
                }
                return imageString
            }
                                         )
            )
        } else if let spell = item as? Spell {
            return AnyView(CardView(cardImage: "globe", name: spell.name, subname: spell.effect ?? "No effect found"))
        } else if let wizard = item as? Wizard {
            return AnyView(CardView(cardImage: "globe", name: wizard.firstName ?? "None", subname: wizard.lastName))
        } else {
            return AnyView(CardView(cardImage: "person.fill", name: "None", subname: "None"))
        }
    }

    private func loadData() async {
        do {
            items = try await ApiServices.shared.fetchData(from: endpoint)
            potionsFromPotterDB = try await ApiServices.shared.fetchAllPotions()
        } catch {
            print("Error fetching data: \(error)")
        }
    }

    private func fetchPotionImage(_ itemName: String) async -> String {
        let slug = convertToSlug(itemName)
        do {
            potionsFromPotterDB = try await ApiServices.shared.fetchAllPotions()

            for potion in potionsFromPotterDB {
                if slug == potion.attributes.slug {
                    if let imageURL = potion.attributes.image {
                        return imageURL
                    }
                } else {
                    return "main-image"
                }
            }
        } catch {
            print("Failed to fetch data: \(error)")
        }
        return "main-image"
    }

    private func convertToSlug(_ name: String) -> String {
        let regex = try! NSRegularExpression(pattern: "(?i)([a-z]+(?:\\s+[a-z]+)*)(?=\\s+em\\s+([a-z]+(?:-[a-z]+)*))", options: [])
        let range = NSRange(location: 0, length: name.utf16.count)

        var slug = regex.stringByReplacingMatches(in: name, options: [], range: range, withTemplate: "")
        print("Regex antes dos updates: \(slug)")
        slug = slug.replacingOccurrences(of: " ", with: "-")
        slug = slug.replacingOccurrences(of: "'", with: "-")


        return slug.lowercased()
    }
}

// Novo CardView para Potions
struct PotionCardView: View {
    let potion: Potion
    @State var imageURL: (() -> String?)

    var body: some View {
        CardView(cardImage: "star.fill", imageURL: imageURL(), name: potion.name, subname: potion.effect ?? "No effect found")
    }
}
