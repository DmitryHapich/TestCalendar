//
//  Models.swift
//  TestCalendar
//
//  Created by Dima H on 13.04.2026.
//
import SwiftUI

// MARK: - Layout Constants

enum TC {
    
    static let hourHeight: CGFloat  = 144
    static let startHour: Int       = 9
    static let endHour: Int         = 19

    static let fullCardWidth: CGFloat  = 310

    static var pixelsPerMinute : CGFloat {
        TC.hourHeight / 60.0
    }
    
    static var totalHeight: CGFloat {
        CGFloat(endHour - startHour) * hourHeight
    }

    static func y(hour: Int, minute: Int = 0) -> CGFloat {
        CGFloat(hour - startHour) * hourHeight
            + CGFloat(minute) / 60.0 * hourHeight
    }
}

enum CardColumn {
    
    static let cardLeft: CGFloat  = 64
    static let cardRight: CGFloat = 16
    static let margin: CGFloat = 4
    
    case full, left, right
    
    func xOffset(for parentWidth: CGFloat) -> CGFloat {
        
        let width = (parentWidth - CardColumn.cardLeft - CardColumn.cardRight)
        
        switch self {
        case .full, .left:
            return CardColumn.cardLeft
        case .right:
            return CardColumn.cardLeft + width / 2 + CardColumn.margin / 2
        }
    }

    func width(for parentWidth: CGFloat) -> CGFloat {
        
        let width = (parentWidth - CardColumn.cardLeft - CardColumn.cardRight)
        
        switch self {
        case .full:
            return width
        case .left, .right:
            return width / 2 - CardColumn.margin / 2
        }
    }
}
