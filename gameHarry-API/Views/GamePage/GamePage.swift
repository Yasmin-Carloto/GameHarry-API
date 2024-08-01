//
//  GamePage.swift
//  gameHarry-API
//
//  Created by Yasmin Carloto on 11/07/24.
//
// TESTANDO AAAA
import SwiftUI

struct GamePage: View {
    var potion: Potion
    @State var correctIngridients: [Ingredients]
    @State var tryIngredients: [Ingredients] = []
    
    init(potion: Potion) {
        self.potion = potion
        self.correctIngridients = potion.ingredients
    }
    
    var body: some View {
        VStack(alignment: .center){
            Text("Fase 1 - Ano 1")
                .font(.cinzelDecorative(.bold))
                .foregroundStyle(.roseEbony)
            
            Text("Selecione os ingredientes que fazem parte dessa poção.")
                .font(.lora(.regular, size: 16))
                .foregroundStyle(.roseEbony)
            
            HStack{
                VStack(alignment: .leading){
                    Text("Seu caldeirão")
                        .font(.lora(.bold, size: 16))
                    
                    IngredientsContainer(ingredients: tryIngredients)
                        .dropDestination(for: Ingredients.self){ choosenIngridients, location in
                            if !tryIngredients.contains(choosenIngridients) {
                                tryIngredients += choosenIngridients
                                for ingredient in correctIngridients {
                                    print(ingredient.name)
                                    correctIngridients.removeAll{ $0.name == choosenIngridients[0].name }
                                }
                            }
                            return true
                        }
                    
                }
                
                VStack{
                    Text(potion.name)
                        .font(.lora(.bold, size: 16))
                    Image("cauldron-empty")
                        .resizable()
                        .frame(width: 200, height: 200)
                }
            }
            .padding()
            
            VStack{
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        ForEach(correctIngridients){ ingredient in
                            VStack{
                                Image("ingredient-placeholder-icon")
                                    .resizable()
                                Text(ingredient.name)
                            }
                            .padding()
                            .foregroundColor(.white)
                            .frame(width: 250, height: 250)
                            .background(.roseEbony)
                            .draggable(ingredient)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                
            }
            .dropDestination(for: Ingredients.self){ tryIngredientsList, location in
                if !correctIngridients.contains(tryIngredientsList) {
                    correctIngridients += tryIngredientsList
                    for ingredient in tryIngredients {
                        tryIngredients.removeAll{ $0.name == tryIngredientsList[0].name }
                    }
                }
                return true
            }
            .frame(height: 300)
            .background(.red)
            
            NavigationLink("Entregar Poção", destination: ReviewPage())
                .buttonStyle(PrimaryButton())
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .paperTexture()
        
    }
    
}
