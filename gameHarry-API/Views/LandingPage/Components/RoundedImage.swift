//
//  RoundedImage.swift
//  gameHarry-API
//
//  Created by User on 08/07/24.
//

import SwiftUI

struct RoundedImage: View {
    var image: String? = nil
    
    var body: some View {
        RoundedRectangle(cornerRadius: 12.0)
            .stroke()
            .fill(Color.white)
            .scaledToFit()
            .frame(maxWidth: 80.0)
            .background(
                RoundedRectangle(cornerRadius: 12.0)
                    .offset(x: 6, y: 6)
                    .fill(LinearGradient(colors: [.roseEbony.opacity(0.5), .roseEbony],
                                         startPoint: .topTrailing,
                                         endPoint: .bottomLeading).opacity(0.6))
                    .blur(radius: 4.0)
                    .overlay(
                        Image(image ?? "main-image")
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    )
            )
    }
}


#Preview {
    RoundedImage()
}
