//
//  SpellsModel.swift
//  gameHarry-API
//
//  Created by Ingryd Cordeiro Duarte on 09/07/24.
//

import Foundation

struct Spell: Codable, Identifiable {
    let id, name: String
    let effect: String?
}
