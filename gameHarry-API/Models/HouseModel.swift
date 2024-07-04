//
//  HouseModel.swift
//  gameHarry-API
//
//  Created by User on 04/07/24.
//

import Foundation

// MARK: - House
struct House: Codable {
    let id, name, houseColours, founder: String
    let animal, element, ghost, commonRoom: String
    let heads: [Head]
    let traits: [Trait]
}

// MARK: - Head
struct Head: Codable {
    let id, firstName, lastName: String
}

// MARK: - Trait
struct Trait: Codable {
    let id, name: String
}
