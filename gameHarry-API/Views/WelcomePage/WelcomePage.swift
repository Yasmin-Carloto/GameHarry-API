//
//  WelcomePage.swift
//  gameHarry-API
//
//  Created by Ingryd Cordeiro Duarte on 03/07/24.
//

import SwiftUI

struct WelcomePage: View {
    var body: some View {
        NavigationStack{
            ZStack {
                Color.roseEbony
                    .ignoresSafeArea()
                
                Image("main-image")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 348, height: 348)
                    .clipped()
                //animation
            }
            .paperTexture()
        }
    }
}

#Preview {
    WelcomePage()
}
