//
//  WikiViewmodel.swift
//  gameHarry-API
//
//  Created by Ingryd Cordeiro Duarte on 09/07/24.
//

import Foundation

class WikiViewModel: ObservableObject{
    class PotionsViewModel: ObservableObject{
        
        var isLoading: Bool = false
        
        func fetchPotions() async -> [Potion] {
            do {
                let fetchedPotions: [Potion] = try await ApiServices.shared.fetchData(from: WizardWorldEndpoint.potions)
                return fetchedPotions
            } catch {
                self.isLoading = false
                print(error.localizedDescription)
                return []
            }
        }
    }
    
    class SpellViewModel: ObservableObject{
        
        var isLoading: Bool = false
        
        func fetchSpells() async -> [Spell] {
            do {
                let fetchedSpells: [Spell] = try await ApiServices.shared.fetchData(from: WizardWorldEndpoint.spells)
                return fetchedSpells
            } catch {
                self.isLoading = false
                print(error.localizedDescription)
                return []
            }
        }
    }
    
    class WizardsViewModel:ObservableObject {
        
        var isLoading: Bool = false
        
        func fetchWizards() async -> [Wizard]{
            do {
                let fetchedWizards: [Wizard] = try await ApiServices.shared.fetchData(from: WizardWorldEndpoint.wizards)
                return fetchedWizards
            } catch {
                self.isLoading = false
                print(error.localizedDescription)
                return []
            }
        }
    }
}
