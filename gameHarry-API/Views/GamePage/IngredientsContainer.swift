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
            VStack{
                ForEach(ingredients){ ingredient in
                    HStack{
                        Image("ingredient-placeholder-icon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                            .padding()
                        Text(ingredient.name)
                            .font(.lora(.bold, size: 12))
                    }
                    .draggable(ingredient)
                }
            }
        }
        .padding()
        .background(.red)
    }
}

#Preview {
    IngredientsContainer(ingredients: [Ingredients(id: "1", name: "aaaaaaaaaaaaaaaaaaaaaaa"), Ingredients(id: "2", name: "aa")])
}
