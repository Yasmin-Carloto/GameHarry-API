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
        VStack(alignment: .leading){
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 170, height: 170)
                .overlay{
                    ZStack{
                        if let imageUrl = imageURL, !imageUrl.isEmpty {
                            // Se imageURL estiver presente, não for vazio e não for "null", use URLImage
                            URLImage(url: imageUrl)
                                .aspectRatio(contentMode: .fill)
                                .foregroundStyle(Color.brown) // Aplica cor de primeiro plano, se necessário
                                .clipped() // Corta a imagem para se ajustar ao contêiner

                        } else {
                            // Caso contrário, use uma imagem de sistema padrão
                            Image(systemName: cardImage ?? "globe")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .foregroundStyle(Color.brown) // Aplica cor de primeiro plano, se necessário
                        }
                        LinearGradient(gradient: Gradient(colors: [Color.roseEbony.opacity(0.7), Color.red.opacity(0.7), Color.black]),
                                       startPoint: .top,
                                       endPoint: .bottom)
                        
                    }
                    VStack{
                        Spacer()
                        Text(self.name)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.cinzelDecorative(.bold, size: 16))
                            .foregroundStyle(Color.white)
                            .truncationMode(.tail)
                        
                        Text(self.subname)
                            .foregroundStyle(Color.white)
                            .font(.cinzelDecorative(.regular,size: 16))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .truncationMode(.tail)
                    }
                    .padding()
                }
                .cornerRadius(12)
        }
    }
}

#Preview {
    CardView(cardImage: nil, name: "Ageing Potion", subname: "Ages the user by years")
}
