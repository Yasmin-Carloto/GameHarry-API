//
//  Font+Extension.swift
//  gameHarry-API
//
//  Created by User on 04/07/24.
//

import SwiftUI

extension Font {
    enum Lora {
        case bold
        case boldItalic
        case italic
        case medium
        case mediumItalic
        case regular
        case semibold
        case semiBoldItalic
        
        var value: String {
            switch self {
                
            case .bold:
                return "Bold"
            case .italic:
                return "Italic"
            case .medium:
                return "Medium"
            case .regular:
                return "Regular"
            case .semibold:
                return "SemiBold"
            case .boldItalic:
                return "SemiBoldItalic"
            case .mediumItalic:
                return "MediumItalic"
            case .semiBoldItalic:
                return "BoldItalic"
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

