//
//  CardView.swift
//  gameHarry-API
//
//  Created by Ingryd Cordeiro Duarte on 10/07/24.
//

import SwiftUI

struct CardView: View {
    let cardImage: String?
    let name, subname: String
    
    var body: some View {
        VStack(alignment: .leading){
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 170, height: 170)
                .overlay{
                    ZStack{
                        Image(systemName: self.cardImage ?? "globe")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .foregroundStyle(Color.brown)
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
