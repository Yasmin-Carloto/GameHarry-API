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
    var gameStatus: StatusGame
    
    var body: some View {
        VStack{
            //random quote
            switch gameStatus {
            case .Win:
                let quote = getRandomQuote(gameFinal: .Win)
                SnapeView(quote: quote ?? "No text for win")
                CauldronStatus(gameStatus: self.gameStatus)
                Spacer()
                Text("PARABÉNS, você passou de ano!")
                    .font(.lora(.bold, size: 18))
                    .foregroundStyle(Color.roseEbony)
                // Atencao toda vez que usar o navigationLink, estao sendo criadas novas instancias
                NavigationLink(destination: TutorialPageView(), label: {
                    Text("Próximo ano")
                })
                .buttonStyle(PrimaryButton())
                .frame(maxWidth: .infinity, alignment: .center)
            case .Lose:
                let quote = getRandomQuote(gameFinal: .Lose)
                SnapeView(quote: quote ?? "No text for lose")
                CauldronStatus(gameStatus: self.gameStatus)
                Spacer()
                Text("PÉSSIMO! Você reprovou de ano!")
                    .font(.lora(.bold, size: 18))
                    .foregroundStyle(Color.roseEbony)
                
                // Atencao toda vez que usar o navigationLink, estao sendo criadas novas instancias
                NavigationLink(destination: TutorialPageView(), label: {
                    Text("Tentar de novo")
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

//pegar randomQuote
enum StatusGame {
    case Win
    case Lose
}
#Preview {
    GameStatusView(gameStatus: .Win)
}
