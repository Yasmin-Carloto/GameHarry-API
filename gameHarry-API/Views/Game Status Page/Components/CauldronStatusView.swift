//
//  CauldronStatusView.swift
//  gameHarry-API
//
//  Created by Ingryd Cordeiro Duarte on 11/07/24.
//

import SwiftUI

struct CauldronStatus: View {
    var gameStatus: StatusGame
    
    var body: some View {
        switch gameStatus {
        case .Win:
            ZStack{
                Image("cauldron-empty")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Image("cauldron-good-potion-liquid")
                    .resizable()
                Image("cauldron-glow")
                    .resizable()
                Image("cauldron-overglow")
                    .resizable()
            }
            .aspectRatio(contentMode: .fit)
            .shadow(radius: 5)
//            .frame(width: 370.0, height: 370.0)
        case .Lose:
            ZStack{
                Image("cauldron-empty-with-spoon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Image("cauldron-bad-potion-color")
                    .resizable()
                Image("cauldron-overglow")
                    .resizable()
            }
            .aspectRatio(contentMode: .fit)
            .shadow(radius: 5)
        }
    }
}
