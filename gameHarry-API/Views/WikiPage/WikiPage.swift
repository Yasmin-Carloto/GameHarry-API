//
//  WikiPage.swift
//  gameHarry-API
//
//  Created by User on 05/07/24.
//

import SwiftUI

struct WikiPage<T: Decodable & Identifiable>: View {
    //debug let numbers = [1,2,3,4]
    @ObservedObject var viewModel: WikiViewModel
    var endpoint: Endpoint
    @State private var items:[T] = []
    @State private var searchItem: String = ""
    @State private var potions: [Datum] = []
    
    var filteredPotions: [Datum] {
        potions.filter { potion in
            searchItem.isEmpty || (potion.attributes.name?.localizedCaseInsensitiveContains(searchItem) ?? false)
        }
    }
    
    var filteredItems: [T] {
        items.filter { item in
            searchItem.isEmpty || String(describing: item).localizedCaseInsensitiveContains(searchItem)
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading){
                Text(endpoint.path.capitalized)
                    .font(.cinzelDecorative(.bold))
                    .padding(2)
                
                //searchBar
                SearchBar(text: $searchItem, placeholder: "Search \(endpoint.path.lowercased())")
                    .padding(3)
                
                if endpoint.path == "elixirs"{
                    // Display potions list
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                            ForEach(filteredPotions) { PotionAttributes in
                                CardView(cardImage: "", imageURL: PotionAttributes.attributes.image,
                                         name: PotionAttributes.attributes.name ?? "Unknown potion ",
                                         subname: PotionAttributes.attributes.effect ?? "Unknown Effect")
                                .onAppear {
                                    getPotion(PotionAttributes.attributes.name!)
                                }
                            }
                        }
                    }
                } else {
                    //Display generic items
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                            ForEach(filteredItems) { item in
                                returnCard(item) // Function to build view
                            }
                        }
                    }
                }
            }
        }
        .task {
            if endpoint.path != "elixirs" {
                do {
                    try await fetchData()
                } catch {
                    print("Error fetching data")
                }
            } else {
                do {
                    try await loadPotions()
                } catch {
                    print("Error fetching potions")
                }
            }
        }
        //page settings
        .foregroundStyle(.roseEbony)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.horizontal, 12)
        .paperTexture()
    }
    //retorna um build
    private func returnCard(_ item: T) -> CardView {
        if let house = item as? House {
            return CardView(cardImage: "globe", name: house.name, subname: house.founder)
        }
        if let potion = item as? Potion {
            return CardView(cardImage: "star.fill", name: potion.name, subname: potion.effect ?? "No effect found")
        }
        if let spells = item as? Spell {
            return CardView(cardImage: "globe", name: spells.name, subname: spells.effect ?? "No effect found")
        }
        if let wizards = item as? Wizard {
            return CardView(cardImage: "globe", name: wizards.firstName ?? "None", subname: wizards.lastName)
        }
        return CardView(cardImage: "person.fill", name: "None", subname: "None")
    }
    
    
    private func fetchData() async throws {
        do {
            items = try await ApiServices.shared.fetchData(from: endpoint)
        } catch {
            print("Error fetching data: \(error)")
            
        }
    }
    
    private func loadPotions() {
        Task {
            do {
                let fetchedPotions = try await ApiServices.shared.fetchAllPotions()
                potions = fetchedPotions
                print(potions)
            } catch {
                print("Failed to fetch data: \(error)")
            }
        }
    }
    private func getPotion(_ item: String) {
        let slugConvertedString = convertToSlug(item)
        Task {
            do {
                let request = PotionEndpoint.RequestPotterDB()
                let result = await NetworkService.shared.request(request,
                                                           using: .shared)
                switch result {
                case .success(let success):
                    success.data.forEach( {
                        print($0.attributes.name)
                    })
                case .failure(let failure):
                    print("deu error")
                }
                let getPotion: Datum = try await ApiServices.shared.fetchData(from: PotterDBEndpoint.potionID(name: slugConvertedString))
                print(getPotion.attributes.image)
                
            } catch {
                print("Failed to fetch data: \(error)")
            }
        }
    }
    /// Converte um nome no formato `Sleekeazy's Hair Potion` para `sleekeazy-s-hair-potion`
    private func convertToSlug(_ name: String) -> String {
        // Define uma expressão regular para encontrar caracteres não alfanuméricos e não espaços
        let regex = try! NSRegularExpression(pattern: "[^a-zA-Z0-9\\s]", options: [])
        let range = NSRange(location: 0, length: name.utf16.count)
        
        // Remove caracteres especiais
        var slug = regex.stringByReplacingMatches(in: name, options: [], range: range, withTemplate: "")
        
        // Substitui espaços por hífens
        slug = slug.replacingOccurrences(of: " ", with: "-")
        
        // Converte para minúsculas
        slug = slug.lowercased()
        
        return slug
    }
}
