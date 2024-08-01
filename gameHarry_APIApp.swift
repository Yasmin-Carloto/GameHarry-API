//
//  gameHarry_APIApp.swift
//  gameHarry-API
//
//  Created by Ingryd Cordeiro Duarte on 03/07/24.
//

import SwiftUI

@main
struct gameHarry_APIApp: App {
    var mockPotion = Potion(id: "1", name: "Age Potion", difficulty: "High", effect: nil, ingredients: [Ingredients(id: "1", name: "Banana"), Ingredients(id: "2", name: "Strawberry")])
    
    var body: some Scene {
        WindowGroup {
            GamePage(potion: mockPotion)
        }
    }
}
