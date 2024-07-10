//
//  CauldronView.swift
//  gameHarry-API
//
//  Created by User on 10/07/24.
//

import SwiftUI

enum CauldronScene {
    case empty
    case success
    case fail
}

struct CauldronView: View {
    @State private var isAnimating: Bool = false
    
    var body: some View {
        ZStack {
            Group {
                Image("cauldron-empty")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                    .compositingGroup()
                    .shadow(color: .white, radius: 2)
                
                    .background {
                        Color.pink.opacity(0.5)
                            .blur(radius: 70)
                            .padding(70)
                    }
                    .overlay {
                        Image("cauldron-overglow")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .opacity(isAnimating ? 1 : 0)
                            .blendMode(.screen)
                        
                            .compositingGroup()
                            .shadow(color: .cyan, radius: 3)
                        
                    }
                
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [.red, .red,.purple, .blue, .purple]),
                                   startPoint: .leading,
                                   endPoint: .bottom)
                    
                    .mask(Image("cauldron-bad-potion-liquid")
                        .resizable()
                        .aspectRatio(contentMode: .fit))
                    Image("cauldron-bad-potion-liquid")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .blendMode(.overlay)
                }
            }
            
        }
        .onAppear {
            withAnimation(
                Animation.easeInOut(duration: 2.0)
                    .repeatForever(autoreverses: true)
            ) {
                isAnimating = true
            }
        }
    }
}

#Preview {
    CauldronView()
}
