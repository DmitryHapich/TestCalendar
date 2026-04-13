//
//  Color+ext.swift
//  TestCalendar
//
//  Created by Dima H on 13.04.2026.
//

import SwiftUI

extension Color {
    
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        self.init(
            red:   Double((rgb & 0xFF0000) >> 16) / 255,
            green: Double((rgb & 0x00FF00) >> 8)  / 255,
            blue:  Double( rgb & 0x0000FF)         / 255
        )
    }
}
