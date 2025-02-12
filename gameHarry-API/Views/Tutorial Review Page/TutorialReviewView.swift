//
//  TutorialReviewView.swift
//  gameHarry-API
//
//  Created by Ingryd Cordeiro Duarte on 11/07/24.
//

import SwiftUI

//text view build
struct TutorialReviewView: View {
    var body: some View {
        VStack(spacing: 10){
            Text("Aprenda a Criar Poções Mágicas!")
                .font(.cinzelDecorative(.bold, size: 24))
            
            Text("Siga as instruções e aprenda a criar poções mágicas usando ingredientes secretos!")
                .font(.lora(.regular, size: 18))
                .multilineTextAlignment(.center)
            
            VStack (alignment: .center, spacing: 10){
                Text("Misture os ingredientes corretamente para preparar cada poção.")
                    .font(.lora(.bold, size: 18))
                    .multilineTextAlignment(.center)
                
                Text("Escolha os ingredientes e adicione-os ao seu caldeirão conforme indicado na sua poção. Você pode encontra-los na bancada.")
                    .font(.lora(.regular, size: 18))
                    .multilineTextAlignment(.center)
            }
            .padding(.top, 20.0)
            VStack(spacing: 20){
                Text("Após fazer todas as poções corretamente, você passará de ano.")
                    .font(.lora(.regular, size: 18))
                    .multilineTextAlignment(.center)
                
                Text("O professor Snape está chegando!")
                    .font(.lora(.regular, size: 18))
                    .multilineTextAlignment(.center)
                Text("Pronto para começar?")
                    .font(.lora(.bold, size: 18))
                    .multilineTextAlignment(.center)
            }
            .padding(.top, 60)
            Spacer()
            //Navigation Button
            HStack{
                NavigationLink(destination: ReviewPage(), label: {
                    Text("Iniciar revisão")
                })
                .buttonStyle(PrimaryButton())
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        //page settings
        .foregroundStyle(.roseEbony) //texts
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.horizontal, 12)
        .paperTexture()
    }
}


#Preview {
    TutorialReviewView()
}
