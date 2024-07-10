//
//  CardPotion.swift
//  gameHarry-API
//
//  Created by Yasmin Carloto on 09/07/24.
//

import SwiftUI

struct CardPotion: View {
    let potion: ElixirModel
    
    var body: some View {
        VStack{
            HStack(alignment: .center){
                Image("potion-placeholder")
                    .frame(height: 100)
                VStack(alignment: .center){
                    Text(potion.name)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.cinzelDecorative(.black))
                       
                        
                    Text(potion.difficulty)
                        .font(.lora(.regular, size: 12))
                }
                .multilineTextAlignment(.center)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(alignment: .leading){
                Text("Ingredients")
                    .font(.cinzelDecorative(.bold, size: 18))
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        ForEach(potion.ingridients) {ingridient in
                            CardIngredient(ingridientName: ingridient.name)
                        }
                    }
                }
            }
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 6)
        .background(Color.coyote)
        .cornerRadius(12)
        .shadow(color: Color.blackShadow, radius: 2, x: 1, y: 3)
        .foregroundColor(Color.white)
    }
}

#Preview {
    let potion = ElixirModel(id: "1", name: "Scurvy Grass", difficulty: "Medium", ingridients: [Ingridient(id: "1", name: "a")])
    return CardPotion(potion: potion)
}
