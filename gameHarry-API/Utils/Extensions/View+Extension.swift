//
//  Modifiers.swift
//  gameHarry-API
//
//  Created by User on 04/07/24.
//

import Foundation
import SwiftUI
// MARK: - Extensions
extension View {
    func paperTexture() -> some View {
        modifier(paperbackground())
    }
}



// MARK: - ViewModifiers
struct paperbackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background {
                Image("paper-texture")
                    .resizable()
                    .scaledToFill()
                    .colorMultiply(Color.sunset)
                    .ignoresSafeArea()
            }
    }
}
