//
//  SnapeModel.swift
//  gameHarry-API
//
//  Created by Ingryd Cordeiro Duarte on 11/07/24.
//

import Foundation

struct SnapeQuotes: Codable{
    let approval: String
    let disapproval: String
}

struct QuotesContainer: Codable {
    let SnapeQuotes: SnapeQuotes
}
