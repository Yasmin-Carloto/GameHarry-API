//
//  LandingPage.swift
//  gameHarry-API
//
//  Created by User on 04/07/24.
//

import SwiftUI

struct LandingPage: View {
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVStack(alignment: .center, content: {
                        ForEach(1...5, id: \.self) { count in
                            RoundedRectangle(cornerRadius: 12.0)
                                .frame(width: 80, height: 80)
                            Text("Feitiços")
                        }
                    })
                }
            }
            VStack {
                Text("Seu ano em hogwarts").font(.title).bold()
                RoundedRectangle(cornerRadius: 12.0)
                    .padding()
            }
            .navigationTitle("Bem Vindo ao Mundo Mágico !")
            .navigationBarTitleDisplayMode(.large)
            .frame(alignment: .center)
        }
    }
}

#Preview {
    LandingPage()
}
