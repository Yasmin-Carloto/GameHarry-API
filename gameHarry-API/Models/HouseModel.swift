//
//  HouseModel.swift
//  gameHarry-API
//
//  Created by User on 04/07/24.
//

import Foundation

// MARK: - House
struct House: Codable, Identifiable {
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


// APENAS PARA TESTES
struct Potion: Decodable, Identifiable {
    let id, name: String
}

struct Spell: Decodable, Identifiable {
    let id, name: String
}

struct Wizard: Decodable, Identifiable {
    let id: String
    let firstName: String?
    let lastName: String
}
