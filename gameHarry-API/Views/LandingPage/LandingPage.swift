//
//  LandingPage.swift
//  gameHarry-API
//
//  Created by User on 04/07/24.
//

import SwiftUI


struct LandingPage: View {
    private let endpoints: [WizardWorldEndpoint] = WizardWorldEndpoint.allCases
    @State private var isAnimating: Bool = false
    
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
                ZStack {
                    Image("cauldron-empty")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                        .overlay {
                            Image("cauldron-overglow")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .opacity(isAnimating ? 1 : 0)
                        }
                    ZStack {
                        LinearGradient(gradient: Gradient(colors: [.blue, .red]),
                                       startPoint: .topLeading,
                                       endPoint: .bottom)
                            .mask(Image("cauldron-good-potion-liquid")
                              .resizable()
                              .aspectRatio(contentMode: .fit))
                        Image("cauldron-good-potion-liquid")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .blendMode(.multiply)
                        
                    }
                }
                
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
        .onAppear {
            withAnimation(
                Animation.easeInOut(duration: 1)
                    .repeatForever(autoreverses: true)
            ) {
                isAnimating = true
            }
        }
        
    }
}

#Preview {
    LandingPage()
}
