//
//  SnapeModel.swift
//  gameHarry-API
//
//  Created by Ingryd Cordeiro Duarte on 11/07/24.
//

import Foundation

struct QuotesContainer: Codable {
    let SnapeQuotes: SnapeQuotes
}

struct SnapeQuotes: Codable{
    let approval, disapproval: [String]
}
