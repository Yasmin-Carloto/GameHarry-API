//
//  CauldronView.swift
//  gameHarry-API
//
//  Created by Ingryd Cordeiro Duarte on 11/07/24.
//

import SwiftUI

struct CauldronView: View {
    var body: some View {
        VStack{
            Image("cauldron-empty")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(Color.white)
        }
    }
}

#Preview {
    CauldronView()
}
