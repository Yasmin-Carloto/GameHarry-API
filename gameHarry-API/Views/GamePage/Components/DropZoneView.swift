//
//  DropZoneView.swift
//  gameHarry-API
//
//  Created by Ingryd Cordeiro Duarte on 11/07/24.
//

import SwiftUI

struct DropZoneView: View {
    //let ingredientName: String
    let numbers = [1,2,3,4,5,6,7,8,9,10] //debug
    
    var body: some View {
        VStack{
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 8){
                ForEach(numbers, id: \.self) { item in
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 100, height: 40)
                        .overlay{
                            ZStack{
                                LinearGradient(gradient: Gradient(colors: [Color.roseEbony.opacity(0.7), Color.black]),
                                               startPoint: .top,
                                               endPoint: .bottom)
                                .blur(radius: 2)
                            }
                            VStack{
                                //image PotterDB
                                Image("potion-placeholder")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }
                        }
                }
            }.cornerRadius(10)
            .frame(width: 100.0)
        }
    }
    //images PotterDB function
    
    //function with the amount of drops
}

#Preview {
    DropZoneView()
}
