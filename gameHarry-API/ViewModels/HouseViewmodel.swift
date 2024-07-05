//
//  HouseViewmodel.swift
//  gameHarry-API
//
//  Created by User on 05/07/24.
//

import Foundation

class HousesViewModel {
    
    var isLoading: Bool = false
    
    func fetchHouses() async -> [House] {
        do {
            let fetchedHouses: [House] = try await ApiServices.shared.fetchData(from: WizardWorldEndpoint.houses)
            return fetchedHouses
        } catch {
            self.isLoading = false
            print(error.localizedDescription)
            return []
        }
    }
}
