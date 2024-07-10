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
    
    var potions: [ElixirModel]
    init(potions: [ElixirModel]){
        self.potions = potions
    }
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
//                Spacer()
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
    }
    
    private func startTimer() {
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            
            if self.sliderValue > 1 {
                self.sliderValue -= 1
            } else {
                timer.invalidate()
                self.timer = nil
            }
            
        }
    }

}

#Preview {
    
    
    return NavigationStack{
        ReviewPage(potions: elixirs)
    }
}
let elixirs: [ElixirModel] = [
    ElixirModel(id: "1", name: "Elixir da Coragem", difficulty: "Avançado", ingridients: [
        Ingridient(id: "1", name: "a"),
        Ingridient(id: "2", name: "a"),
        Ingridient(id: "3", name: "a")
    ]),
    ElixirModel(id: "2", name: "Poção do Amor", difficulty: "Intermediário", ingridients: [
        Ingridient(id: "4", name: "a"),
        Ingridient(id: "5", name: "a"),
        Ingridient(id: "6", name: "a"),
    ]),
    ElixirModel(id: "3", name: "Poção de Invisibilidade", difficulty: "Avançado", ingridients: [
        Ingridient(id: "7", name: "a"),
        Ingridient(id: "8", name: "a"),
        Ingridient(id: "9", name: "a"),
    ])
]
