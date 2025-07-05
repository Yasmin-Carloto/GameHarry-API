//
//  TextShimmer.swift
//  gameHarry-API
//
//  Created by User on 08/07/24.
//

import SwiftUI

struct TextShimmer: View {
    @State private var animation = false
    var text: String
    var fontType: Font
    var color: Color
    var alignment: TextAlignment
    
    var body: some View {
        ZStack {
            Text(text)
                .font(fontType)
                .foregroundColor(color.opacity(0)) // Texto invisível inicialmente
                .multilineTextAlignment(alignment)
            
            Text(text)
                .font(fontType)
                .foregroundColor(color)
                .multilineTextAlignment(alignment)
                .mask(
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: animation ? UIScreen.main.bounds.width : 0, height: UIScreen.main.bounds.height)
                    
                        .blur(radius: 12)
                        .rotationEffect(Angle(degrees: 70))
                        .offset(x: animation ? 0 : -UIScreen.main.bounds.width / 2)
                        .animation(Animation.easeIn(duration: 4), value: animation)
                )
                .onAppear {
                    withAnimation {
                        animation.toggle()
                    }
                }
        }
        
        .frame(maxWidth: .infinity, alignment: .center)
    }
}
