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
            VStack(alignment: .leading, spacing: 40.0) {
                TextShimmer(text: "Welcome to Hogwarts",
                            fontType: .cinzelDecorative(.bold, size: 36),
                            color: .roseEbony, alignment: .center)
                HStack {
                    ForEach(endpoints, id: \.self) { endpoint in
                        NavigationLink(destination: WikiPageFactory.createWikiPage(for: endpoint)) {
                            
                            VStack {
                                RoundedImage()
                                Text(endpoint.path.capitalized(with: .autoupdatingCurrent))
                                    .font(.lora(.semibold))
                            }
                        }
                    }
                    .padding(.horizontal, 8.0)
                }
                
                Text("Seu ano em hogwarts")
                    .font(.cinzelDecorative(.bold))
                    .foregroundStyle(.roseEbony)
                
                Button("Começar") {
                    
                }
                .buttonStyle(PrimaryButton())
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .foregroundStyle(.roseEbony)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(.horizontal, 12)
            .paperTexture()
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

#Preview {
    LandingPage()
}
