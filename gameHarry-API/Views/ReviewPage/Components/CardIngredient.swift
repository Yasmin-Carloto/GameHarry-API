//
//  CardIngredient.swift
//  gameHarry-API
//
//  Created by Yasmin Carloto on 09/07/24.
//

import SwiftUI

struct CardIngredient: View {
    var ingridientName: String
    
    var body: some View {
        VStack{
            Image("ingredient-placeholder-icon")
                .resizable()
                .scaledToFit()
                .foregroundStyle(Color.white)
                .frame(width: 80, height: 50)
            Text(ingridientName)
                .foregroundStyle(Color.white)
                .font(.caption)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 80, maxHeight: .infinity)
                .lineLimit(10)
        }
        .frame(width: 80)
        .padding(.vertical, 2)
        .padding(.horizontal, 6)
        .background(Color.darkCoyote)
        .cornerRadius(12)
        .shadow(color: Color.darkSunset, radius: 1.5, x: 0, y: 0)
    }
}

#Preview {
    CardIngredient(ingridientName: "Scurvy Grassfffffffffffffffffffffff fffffffffffffff")
}
