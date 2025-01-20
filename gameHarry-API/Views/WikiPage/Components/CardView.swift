//
//  CardView.swift
//  gameHarry-API
//
//  Created by Ingryd Cordeiro Duarte on 10/07/24.
//

import SwiftUI

struct CardView: View {
    let cardImage: String?
    var imageURL: String?
    let name, subname: String
    
    var body: some View {
        VStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10)
                .aspectRatio(contentMode: .fit)
                .overlay {
                    ZStack{
                        if let imageUrl = imageURL, !imageUrl.isEmpty {
                            // Se imageURL estiver presente, não for vazio e não for "null", use URLImage
                            URLImage(url: imageUrl)
                                .aspectRatio(contentMode: .fit)
                                .foregroundStyle(Color.brown) // Aplica cor de primeiro plano, se necessário
                                .clipped() // Corta a imagem para se ajustar ao contêiner
                                .frame(maxWidth: .infinity, maxHeight: .infinity)

                        } else {
                            // Caso contrário, use uma imagem de sistema padrão
                            Image(systemName: cardImage ?? "globe")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundStyle(Color.brown) // Aplica cor de primeiro plano, se necessário
                        }
                        LinearGradient(gradient: Gradient(colors: [Color.roseEbony.opacity(0.2), Color.red.opacity(0.6), Color.black]),
                                       startPoint: .top,
                                       endPoint: .bottom)
                        
                    }
                    VStack(alignment: .leading) {
                        Spacer()
                        Text(self.name)
                            .font(.cinzelDecorative(.bold, size: 16))
                            .lineLimit(2)
                            .foregroundStyle(Color.white)
                            .padding([.leading], 6)

                        Text(self.subname)
                            .foregroundStyle(Color.white)
                            .lineLimit(2)
                            .font(.cinzelDecorative(.regular,size: 14))
                            .padding([.leading,.bottom], 6)
                            .truncationMode(.tail)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                }
                .cornerRadius(12)
        }
        .frame(alignment:.leading)
        .shadow(color: .roseEbony, radius: 6, x: 1, y: 2)
    }
}

#Preview {
    CardView(cardImage: nil, name: "Ageing Potion", subname: "Ages the user by years")
}
