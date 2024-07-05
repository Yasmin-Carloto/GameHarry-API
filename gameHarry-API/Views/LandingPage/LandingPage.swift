//
//  LandingPage.swift
//  gameHarry-API
//
//  Created by User on 04/07/24.
//

import SwiftUI

struct LandingPage: View {
    private let endpoints: [WizardWorldEndpoint] = WizardWorldEndpoint.allCases
    
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack(spacing: 20.0) {
                    ForEach(endpoints, id: \.self) { endpoint in
                        NavigationLink(endpoint.path.capitalized(with: .autoupdatingCurrent),
                                       destination: WikiPageFactory.createWikiPage(for: endpoint))
                    }
                }
            }
            
            Text("Seu ano em hogwarts")
                .font(.cinzelDecorative(.bold))
            RoundedRectangle(cornerRadius: 12.0)
            Spacer()
            Button(action: {
                //
            }, label: {
                Text("Começar")
                    .padding()
                
            })
        }
        .padding()
        .paperTexture()
        .navigationTitle("Welcome to Hogwarts !")
        .navigationBarTitleDisplayMode(.large)
    }
}

class WikiPageFactory {
    static func createWikiPage(for endpoint: WizardWorldEndpoint) -> some View {
        switch endpoint {
        case .houses:
            return AnyView(WikiPage<House>(endpoint: endpoint))
        case .potions:
            return AnyView(WikiPage<Potion>(endpoint: endpoint))
        case .spells:
            return AnyView(WikiPage<Spell>(endpoint: endpoint))
        case .wizards:
            return AnyView(WikiPage<Wizard>(endpoint: endpoint))

        }
    }
}

#Preview {
    LandingPage()
}
