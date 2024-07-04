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
            VStack(alignment: .leading) {
                HStack(spacing: 30.0, content: {
                    Spacer()
                    ForEach(1...3, id: \.self) { count in
                        VStack {
                            RoundedRectangle(cornerRadius: 12.0)
                                .frame(width: 80, height: 80)
                            Text("Feitiços").font(.lora(.regular))
                            
                                
                        }
                    }
                    Spacer()
                })
                Spacer()
                Text("Seu ano em hogwarts")
                    .font(.cinzelDecorative(.bold))
                RoundedRectangle(cornerRadius: 12.0)
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Começar")
                        
                })
            }
            .padding()
            .paperTexture()
            .navigationTitle("Welcome to Hogwarts !")
            .navigationBarTitleDisplayMode(.large)
            
        }
    }
}

#Preview {
    LandingPage()
}
