//
//  SettingsPage.swift
//  gameHarry-API
//
//  Created by Ingryd Cordeiro Duarte on 03/07/24.
//

import SwiftUI

struct SettingsPage: View {
    var body: some View {
        ZStack(){
            Text("Preparado(a) para embarcar em uma aventura mágica?")
                .fontWeight(.bold)
                .foregroundColor(Color(red: 0.37, green: 0.24, blue: 0.22))
                .multilineTextAlignment(.center)
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }
        
            .frame(width: 400.0, height: 880)
            .background(Color(red: 0.93, green: 0.81, blue: 0.64))
            
    }
}

#Preview {
    SettingsPage()
}
