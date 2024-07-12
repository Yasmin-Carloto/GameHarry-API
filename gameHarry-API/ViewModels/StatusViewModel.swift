//
//  StatusViewModel.swift
//  gameHarry-API
//
//  Created by Ingryd Cordeiro Duarte on 11/07/24.
//

import Foundation

@Observable
class SnapeStatusViewModel {
    func loadSnapeQuotes() throws -> SnapeQuotes {
            guard let url = Bundle.main.url(forResource: "SnapeQuotes", withExtension: "json") else {
                print("Failed to locate SnapeQuotes.json in bundle.")
                throw URLError(.cannotOpenFile)
            }
        let data = try Data(contentsOf: url)
        let quotes = try? JSONDecoder().decode(QuotesContainer.self, from: data)
        return quotes!.SnapeQuotes
        }
}
