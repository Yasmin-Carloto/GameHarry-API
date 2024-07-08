//
//  SearchBar.swift
//  gameHarry-API
//
//  Created by Ingryd Cordeiro Duarte on 08/07/24.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var placeholder: String //pega o "hint"
    
    var body: some View{
        HStack{
            //recebe o text
            TextField(placeholder, text: $text )
                .textFieldStyle(RoundedBorderTextFieldStyle())
                //.frame(width: 360, height: 40)
                .background(Color.searchBar)
                .cornerRadius(12)
                //paddings
        }
        .padding(2)
    }
}
