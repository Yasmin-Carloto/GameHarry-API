//
//  ElixirViewModel.swift
//  gameHarry-API
//
//  Created by Yasmin Carloto on 10/07/24.
//

import Foundation
class ElixirViewModel {
    
    var isLoading: Bool = false
    
    func fetchElixirs() async -> [ElixirModel] {
        do {
            let fetchedElixirs: [ElixirModel] = try await ApiServices.shared.fetchData(from: WizardWorldEndpoint.potions) /*try await ApiServices.shared.fetchData(from: WizardWorldEndpoint.houses)*/
            let filteredElixirs = filterElixirs(elixirs: fetchedElixirs)
            return filteredElixirs
        } catch {
            self.isLoading = false
            print(error.localizedDescription)
            return []
        }
    }
    
    func filterElixirs(elixirs: [ElixirModel]) -> [ElixirModel]{
        var filteredElixirs: [ElixirModel] = []
        
        for potion in elixirs {
            if potion.ingridients.count > 0{
                filteredElixirs.append(potion)
            }
        }
        return filteredElixirs
    }
}
