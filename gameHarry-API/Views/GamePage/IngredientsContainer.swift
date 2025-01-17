//
//  IngredientsContainer.swift
//  gameHarry-API
//
//  Created by Yasmin Carloto on 11/07/24.
//

import SwiftUI

struct IngredientsContainer: View {
    var ingredients: [Ingredients]
    
    var body: some View {
        ScrollView{
            VStack (alignment: .center){
                ForEach(ingredients){ ingredient in
                    HStack{
                        Image("ingredient-placeholder-icon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40)
                            .padding()
                        Text(ingredient.name)
                            .font(.lora(.bold, size: 12))
                            .foregroundStyle(Color.white)
                            .padding()
                    }
                    .draggable(ingredient)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.darkSunset.opacity(0.8), Color.roseEbony.opacity(0.8)]),
                                               startPoint: .top,
                                               endPoint: .bottom))
            }
        }
    }.frame(width: 160.0)
        .background(.coyote.opacity(0.5))
        .cornerRadius(12)
        .padding()
    
}
}

#Preview {
    IngredientsContainer(ingredients: [Ingredients(id: "1", name: ""), Ingredients(id: "2", name: "aa")])
}
