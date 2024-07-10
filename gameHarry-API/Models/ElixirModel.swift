//
//  ElixirModel.swift
//  gameHarry-API
//
//  Created by Yasmin Carloto on 09/07/24.
//

import Foundation
struct ElixirModel: Codable, Identifiable {
    let id: String
    let name: String
    let difficulty: String
    let ingridients: [Ingridient]
}

// Requisitar poções pra view
// Usar o Dispatch Queue para atualizar a view assincronamente
