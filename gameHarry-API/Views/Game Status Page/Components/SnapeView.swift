//
//  SnapeView.swift
//  gameHarry-API
//
//  Created by Ingryd Cordeiro Duarte on 11/07/24.
//

import SwiftUI

struct SnapeView: View {
    let quote: String
    
    var body: some View {
        HStack(alignment: .center){
            Image("snape-icon")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100.0, height: 100.0)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(radius: 3)
            
            ZStack(alignment: .center){
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: 270, height: 110)
                    .foregroundStyle(Color.white)
                    .shadow(radius: 3)
                    .overlay{
                        Text(self.quote)
                            .frame(maxWidth: .infinity)
                            .font(.lora(.semibold, size: 14))
                            .truncationMode(.tail)
                            .padding(4)
                            .multilineTextAlignment(.leading)
                    }
            }
        }
    }
}

#Preview {
    SnapeView(quote: "Impressionante, devo admitir. Sua poção está perfeita. Quem diria que você conseguiria seguir uma simples receita? Continue assim.")
}
