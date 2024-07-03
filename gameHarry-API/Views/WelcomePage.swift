//
//  WelcomePage.swift
//  gameHarry-API
//
//  Created by Ingryd Cordeiro Duarte on 03/07/24.
//

import SwiftUI

struct WelcomePage: View {
    var body: some View {
        ZStack {
            Image("mainImage")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 348, height: 348)
            .clipped()
            //animation
        }
        .frame(width: 393, height: 852)
        .background(Color(red: 0.37, green: 0.24, blue: 0.22))
    }
}

#Preview {
    WelcomePage()
}
