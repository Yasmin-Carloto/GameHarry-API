//
//  CardIngredientView.swift
//  gameHarry-API
//
//  Created by Ingryd Cordeiro Duarte on 11/07/24.
//

import SwiftUI

struct CardIngredientView: View {
    let ingredient: String
    
    var body: some View {
        VStack{
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 200, height: 190)
                .blur(radius: 4.0)
                .overlay{
                    ZStack{
                        LinearGradient(gradient: Gradient(colors: [Color.darkSunset.opacity(0.8), Color.roseEbony.opacity(0.8)]),
                                       startPoint: .top,
                                       endPoint: .bottom)
                    }
                    VStack{
                        Spacer()
                        Image("ingredient-placeholder-icon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(Color.white)
                        
                        Text(self.ingredient)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .font(.cinzelDecorative(.bold, size: 16))
                            .foregroundStyle(Color.white)
                            .truncationMode(.tail)
                            .padding(5)
                    }
                    .padding()
                }
                .cornerRadius(12)
        }
        
    }
}

#Preview {
    CardIngredientView(ingredient: "Ageing Potion")
    //CardIngredientView()
}
