//
//  ElixirModel.swift
//  gameHarry-API
//
//  Created by Yasmin Carloto on 09/07/24.
//

import Foundation
struct Potion: Codable, Identifiable {
    let id: String
    let name: String
    let difficulty: String
    let ingredients: [Ingredients]
}
