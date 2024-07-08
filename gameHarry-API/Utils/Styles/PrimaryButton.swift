//
//  PrimaryButton.swift
//  gameHarry-API
//
//  Created by User on 08/07/24.
//

import SwiftUI

struct PrimaryButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.cinzelDecorative(.bold)).foregroundStyle(.white)
            .padding(.horizontal, 50)
            .padding(.vertical, 20)
            .background {
                Color.roseEbony
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(content: {
                RoundedRectangle(cornerRadius: 12)
                    .stroke()
                    .foregroundStyle(.white)
            })
            .shadow(color: .roseEbony, radius: 4, x: 1, y:5)

    }
}
