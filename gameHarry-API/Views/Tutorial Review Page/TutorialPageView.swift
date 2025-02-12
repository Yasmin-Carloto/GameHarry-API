//
//  TutorialPageView.swift
//  gameHarry-API
//
//  Created by Ingryd Cordeiro Duarte on 11/07/24.
//

import SwiftUI

struct TutorialPageView: View {
    
    var body: some View {
        VStack(spacing: 10){
            Text("Aprenda a Criar Poções Mágicas!")
                .font(.cinzelDecorative(.bold, size: 24))
                .foregroundStyle(Color.roseEbony)
            
            Text("Sabemos que nem todo estudante bruxo consegue estudar todo o conteúdo de uma vez. Mas não se preocupe!")
                .font(.lora(.regular, size: 18))
                .multilineTextAlignment(.center)
            
            VStack (alignment: .center, spacing: 10){
                Text("Você tem alguns segundos antes que o professor Snape chegue aos calabouços para a aula de poções.")
                    .font(.lora(.bold, size: 18))
                    .multilineTextAlignment(.center)
            }
            .padding(.top, 20.0)
            VStack(spacing: 20){
                Text("Aproveite esse tempo para revisar o máximo possível de ingredientes e poções necessários para o seu teste. Confira suas anotações, cartas e pergaminhos mágicos e esteja preparado!")
                    .font(.lora(.regular, size: 18))
                    .multilineTextAlignment(.center)
                
                Text("Pronto para começar?")
                    .font(.lora(.bold, size: 18))
                    .multilineTextAlignment(.center)
            }
            .padding(.top, 20)
            Spacer()
            //botao
            HStack{
                NavigationLink(destination: TutorialReviewView(), label: {
                    Text("Começar")
                })
                .buttonStyle(PrimaryButton())
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        //page settings
        .foregroundStyle(.roseEbony)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.horizontal, 12)
        .paperTexture()
    }
}


#Preview {
    TutorialPageView()
}
