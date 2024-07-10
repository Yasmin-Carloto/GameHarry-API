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
                //ScrollView + LazyVGrid
                ScrollView{
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20){
                        ForEach(filteredItems) { item in
                            returnCard(item) //funcao de ViewBuild
                            
                        }
                    }
                }
            }
        }
        .task {
            do {
                try await fetchData()
            } catch {
                print("Error fetching data")
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
            print(items)
        } catch {
            print("Error fetching data: \(error)")
            
        }
    }
}
