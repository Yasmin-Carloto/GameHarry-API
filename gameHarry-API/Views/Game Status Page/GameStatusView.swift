//
//  GameStatusView.swift
//  gameHarry-API
//
//  Created by Ingryd Cordeiro Duarte on 11/07/24.

import SwiftUI
import Foundation

struct GameStatusView: View {
    @State private var quote: String = ""
    var viewModel: SnapeStatusViewModel = SnapeStatusViewModel()
    @State var allQuotes: SnapeQuotes?
    
    var body: some View {
        VStack{
            //random quote
            if let quote = getRandomQuote(gameFinal: .Lose) {
                SnapeView(quote: quote)
                
                CauldronStatusBad()
                Spacer()
                Text("PÉSSIMO! Você reprovou de ano!")
                    .font(.lora(.bold, size: 18))
                    .foregroundStyle(Color.roseEbony)
                
                NavigationLink(destination: TutorialPageView(), label: {
                    Text("Tentar de novo")
                })
                .buttonStyle(PrimaryButton())
                .frame(maxWidth: .infinity, alignment: .center)
                
            } else if let quote = getRandomQuote(gameFinal: .Win){
                SnapeView(quote: quote)
                
                CauldronStatusGood()
                Spacer()
                Text("PARABÉNS, você passou de ano!")
                    .font(.lora(.bold, size: 18))
                    .foregroundStyle(Color.roseEbony)
                
                NavigationLink(destination: LandingPage(), label: {
                    Text("Passar ano")
                })
                .buttonStyle(PrimaryButton())
                .frame(maxWidth: .infinity, alignment: .center)
            }
    }
        
        
        //page settings
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding([.top, .leading, .trailing], 12)
        .paperTexture()
        .onAppear {
            do {
                allQuotes = try viewModel.loadSnapeQuotes()
            } catch {
                print("Erro aqui")
            }
        }
    }
    
    //    private func cauldronStatus() -> CauldronView{
    //        let win = true // Example condition
    //
    //        if win {
    //            return CauldronStatusGood()
    //        } else {
    //            return CauldronStatusBad()
    //        }
    //    }
    
    //pegar randomQuote
    enum StatusGame {
        case Win
        case Lose
    }
    
    func getRandomQuote(gameFinal: StatusGame) -> String? {
        if let allQuotes = allQuotes {
            if gameFinal == StatusGame.Win {
                return allQuotes.approval.randomElement()
            } else {
                return allQuotes.disapproval.randomElement()
            }
        }
        return "No comments"
    }
}

#Preview {
    GameStatusView()
}
