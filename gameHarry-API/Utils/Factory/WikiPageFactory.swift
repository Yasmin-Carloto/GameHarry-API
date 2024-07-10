//
//  WikiPageFactory.swift
//  gameHarry-API
//
//  Created by User on 08/07/24.
//

import SwiftUI

class WikiPageFactory {
    static func createWikiPage(for endpoint: WizardWorldEndpoint) -> some View {
        switch endpoint {
        case .houses:
            return AnyView(WikiPage<House>(viewModel: WikiViewModel(),endpoint: endpoint))
        case .potions:
            return AnyView(WikiPage<Potion>(viewModel: WikiViewModel(), endpoint: endpoint))
        case .spells:
            return AnyView(WikiPage<Spell>(viewModel: WikiViewModel(), endpoint: endpoint))
        case .wizards:
            return AnyView(WikiPage<Wizard>(viewModel: WikiViewModel(), endpoint: endpoint))

        }
    }
}
