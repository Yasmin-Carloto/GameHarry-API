//
//  WikiViewmodel.swift
//  gameHarry-API
//
//  Created by Ingryd Cordeiro Duarte on 08/07/24.
//

import Foundation
//TODO: verifique o endpoint e puxe uma viewmodel?


// MARK: - Spells
class SpellsViewModel: ObservableObject {
    @Published var title: String = "Feitiços"
    
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

// MARK: - Wizards
class WizardViewModel: ObservableObject {
    @Published var title: String = "Bruxos"
    
    var isLoading: Bool = false
    
    func fetchWizards() async -> [Wizard] {
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

// MARK: - Potions
class PotionsViewModel: ObservableObject {
    @Published var title: String = "Poções"
    
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

