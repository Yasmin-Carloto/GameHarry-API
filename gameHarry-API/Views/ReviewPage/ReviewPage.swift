//
//  ReviewPage.swift
//  gameHarry-API
//
//  Created by Yasmin Carloto on 09/07/24.
//

import SwiftUI

struct ReviewPage: View {
    @State private var sliderValue: Double = 30
    @State private var timer: Timer? = nil
    private var upperBound: Int = 30
    private var viewModel: ElixirViewModel = ElixirViewModel()
    
    @State private var potions: [Potion] = []

    var body: some View {
        VStack(alignment: .center) {
            Text("Prepare-se para a aula de poções!")
                .font(.cinzelDecorative(.bold))
                .multilineTextAlignment(.center)
            
            VStack {
                
                ReviewTimer(timePassedValue: $sliderValue, in: 1...upperBound)
                    .padding(.horizontal, 20)
                ScrollView(.vertical, showsIndicators: false){
                    ForEach(potions){ potion in
                        CardPotion(potion: potion)
                    }
                }

                NavigationLink("Pular Revisão", destination: LandingPage().navigationBarBackButtonHidden())
                    .buttonStyle(PrimaryButton())
                    .frame(maxWidth: .infinity, alignment: .center)
                    
            }
            .frame(maxHeight: .infinity)
        }
        .padding()
        .foregroundStyle(.roseEbony)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .paperTexture()
        .onAppear(perform: {
            startTimer()
        })
        .task {
            do {
                potions = try await viewModel.fetchElixirs()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func startTimer() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if self.sliderValue > 1 {
                self.sliderValue -= 1
            } else {
                self.sliderValue = 1
            }
            startTimer()
        }
    }

}

#Preview {
    
    
    return NavigationStack{
        ReviewPage()
    }
}
let elixirs: [Potion] = [
    Potion(id: "1", name: "Elixir da Coragem", difficulty: "Avançado", ingredients: [
        Ingredients(id: "1", name: "a"),
        Ingredients(id: "2", name: "a"),
        Ingredients(id: "3", name: "a")
    ]),
    Potion(id: "2", name: "Poção do Amor", difficulty: "Intermediário", ingredients: [
        Ingredients(id: "4", name: "a"),
        Ingredients(id: "5", name: "a"),
        Ingredients(id: "6", name: "a"),
    ]),
    Potion(id: "3", name: "Poção de Invisibilidade", difficulty: "Avançado", ingredients: [
        Ingredients(id: "7", name: "a"),
        Ingredients(id: "8", name: "a"),
        Ingredients(id: "9", name: "a"),
    ])
]
