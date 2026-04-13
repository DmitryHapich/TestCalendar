//
//  Fonts+ext.swift
//  TestCalendar
//
//  Created by Dima H on 13.04.2026.
//

import UIKit
import SwiftUI

extension Font {
    static func enkel(size: CGFloat) -> Font {
        Font.custom("Enkel", size: size)
    }
}

extension UIFont {
    
    static func enkel(size: CGFloat = 16, weight: UIFont.Weight = .regular) -> UIFont? {
        
        let family = "Enkel"
        let name: String
        switch weight {
        case .regular:    name = "\(family)-Regular"
        case .medium:     name = "\(family)-Medium"
        case .semibold:   name = "\(family)-SemiBold"
        case .bold:       name = "\(family)-Bold"
        case .light:      name = "\(family)-Light"
        case .ultraLight: name = "\(family)-ExtraLight"
        case .black:      name = "\(family)-Black"
        case .thin:       name = "\(family)-Thin"
        default:          name = "\(family)-Regular"
        }
        return UIFont(name: name, size: size)
        
    }
}
