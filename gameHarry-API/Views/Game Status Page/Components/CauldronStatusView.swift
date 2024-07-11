//
//  CauldronStatusView.swift
//  gameHarry-API
//
//  Created by Ingryd Cordeiro Duarte on 11/07/24.
//

import SwiftUI

struct CauldronStatusGood: View {
    var body: some View {
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
        .shadow(radius: 5)
        .frame(width: 370.0, height: 370.0)
    }
}

struct CauldronStatusBad: View{
    var body: some View{
        ZStack{
            Image("cauldron-empty-with-spoon")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Image("cauldron-bad-potion-color")
                .resizable()
            Image("cauldron-overglow")
                .resizable()
        }
        .shadow(radius: 5)
        .frame(width: 370.0, height: 370.0)
    }
}
