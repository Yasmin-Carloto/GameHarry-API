//
//  Font+Extension.swift
//  gameHarry-API
//
//  Created by User on 04/07/24.
//

import SwiftUI

extension Font {
    enum Lora {
        case regular
        
        var value: String {
            switch self {
                
            case .regular:
                return "VariableFont_wght"
            }
        }
    }
    
    enum CinzelDecorativeFont {
        case black
        case bold
        case regular
        
        var value: String {
            switch self {
                
            case .black:
                return "Black"
            case .bold:
                return "Bold"
            case .regular:
                return "Regular"
            }
        }
    }
    
    static func cinzelDecorative(_ type: CinzelDecorativeFont, size: CGFloat = 24) -> Font {
        var fontName = "CinzelDecorative-"
        fontName.append(type.value)
        return Font.custom(fontName, size: size)
        
    }
    
    static func lora(_ type: Lora, size: CGFloat = 18) -> Font {
        var fontName = "Lora-"
        fontName.append(type.value)
        return Font.custom(fontName, size: size)
    }
}
