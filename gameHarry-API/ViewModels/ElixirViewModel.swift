//
//  ElixirViewModel.swift
//  gameHarry-API
//
//  Created by Yasmin Carloto on 10/07/24.
//

import Foundation
class ElixirViewModel {
    
    var isLoading: Bool = false
    
    func fetchElixirs() async -> [Potion] {
        do {
            let fetchedElixirs: [Potion] = try await ApiServices.shared.fetchData(from: WizardWorldEndpoint.potions)
            let filteredElixirs = filterElixirs(elixirs: fetchedElixirs)
            return filteredElixirs.shuffled()
        } catch {
            self.isLoading = false
            print(error.localizedDescription)
            return []
        }
    }
    
    private func filterElixirs(elixirs: [Potion]) -> [Potion]{
        var filteredElixirs: [Potion] = []
        
        for potion in elixirs {
            if potion.ingredients.count > 0 && potion.difficulty != "Unknown"{
                filteredElixirs.append(potion)
            }
        }
        return filteredElixirs
    }
}
