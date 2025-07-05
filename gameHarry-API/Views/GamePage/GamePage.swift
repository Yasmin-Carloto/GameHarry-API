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
    @State var correctIngridients: [Ingredients]  // Altere para o tipo correto
    @State var tryIngredients: [Ingredients] = []
    var mockPotion = Potion(id: "1", name: "Age Potion", difficulty: "High", effect: nil, ingredients: [Ingredients(id: "1", name: "Banana"), Ingredients(id: "2", name: "Strawberry")])
    
    init(potion: Potion) {
        self.potion = potion
        self._correctIngridients = State(initialValue: potion.ingredients)
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
                        .dropDestination(for: Ingredients.self) { choosenIngridients, location in
                            for ingredient in choosenIngridients {
                                if !tryIngredients.contains(where: { $0.id == ingredient.id }) {
                                    tryIngredients.append(ingredient)
                                    // Remover o ingrediente da lista correta
                                    if let index = correctIngridients.firstIndex(where: { $0.id == ingredient.id }) {
                                        correctIngridients.remove(at: index)
                                    }
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
                            CardIngredientView(ingredient: ingredient.name)
                                .padding()
                                .foregroundStyle(.white)
                                .frame(width: 250, height: 250)
                                .draggable(ingredient)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                
            }
            .dropDestination(for: Ingredients.self) { tryIngredientsList, location in
                for ingredient in tryIngredientsList {
                    if !correctIngridients.contains(where: { $0.id == ingredient.id }) {
                        correctIngridients.append(ingredient)
                        // Remover o ingrediente da lista de tentativa
                        if let index = tryIngredients.firstIndex(where: { $0.id == ingredient.id }) {
                            tryIngredients.remove(at: index)
                        }
                    }
                }
                return true
            }
            .frame(height: 300)
            
            NavigationLink("Entregar Poção", destination: ReviewPage())
                .buttonStyle(PrimaryButton())
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .paperTexture()
    }
}
