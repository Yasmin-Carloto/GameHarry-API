//
//  PotterDBModel.swift
//  gameHarry-API
//
//  Created by User on 11/07/24.
//

import Foundation

// MARK: - PotterDB
struct PotterDB: Codable {
    let data: [ItemData]
}

// MARK: - Datum
struct ItemData: Codable, Identifiable {
    let id: String
    let type: TypeEnum
    let attributes: PotionAttributes
//    let links: DatumLinks
}

// MARK: - PotionAttributes
struct PotionAttributes: Codable {
    let slug: String?
    let characteristics: String?
    let difficulty: String?
    let effect: String?
    let image: String?
    let inventors: String?
    let ingredients: String?
    let manufacturers: String?
    let name: String?
    let sideEffects: String?
    let time: String?
    let wiki: String?

    enum CodingKeys: String, CodingKey {
        case slug, characteristics, difficulty, effect, image, inventors, ingredients, manufacturers, name
        case sideEffects = "side_effects"
        case time, wiki
    }
}

// MARK: - DatumLinks
struct DatumLinks: Codable {
    let linksSelf: String

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }
}

enum TypeEnum: String, Codable {
    case potion = "potion"
}
