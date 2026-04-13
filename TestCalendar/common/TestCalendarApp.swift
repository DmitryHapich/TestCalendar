//
//  TestCalendarApp.swift
//  TestCalendar
//
//  Created by Dima H on 13.04.2026.
//

import SwiftUI

@main
struct TestCalendarApp: App {
    init() {
        setupTabBar()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }

    func setupTabBar() {
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = .tcMenuBG
        
        let normalAttrs: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.tcCalTitle,
            .font: UIFont.enkel(size: 10, weight: .semibold)
        ]
        let selectedAttrs: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.tcCalTitle,
            .font: UIFont.enkel(size: 10, weight: .semibold)
        ]
        
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = normalAttrs
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedAttrs
        
        appearance.inlineLayoutAppearance.normal.titleTextAttributes = normalAttrs
        appearance.inlineLayoutAppearance.selected.titleTextAttributes = selectedAttrs
        
        appearance.compactInlineLayoutAppearance.normal.titleTextAttributes = normalAttrs
        appearance.compactInlineLayoutAppearance.selected.titleTextAttributes = selectedAttrs
        
        appearance.stackedLayoutAppearance.normal.iconColor = .tcCalTitle
        appearance.stackedLayoutAppearance.selected.iconColor = .tcCalTitle
        
        appearance.inlineLayoutAppearance.normal.iconColor = .tcCalTitle
        appearance.inlineLayoutAppearance.selected.iconColor = .tcCalTitle
        
        appearance.compactInlineLayoutAppearance.normal.iconColor = .tcCalTitle
        appearance.compactInlineLayoutAppearance.selected.iconColor = .tcCalTitle
        
        appearance.selectionIndicatorTintColor = .clear
        
        appearance.shadowColor = nil
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}
