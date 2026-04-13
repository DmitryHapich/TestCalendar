//
//  ContentView.swift
//  TestCalendar
//
//  Created by Dima H on 13.04.2026.
//

import SwiftUI
import UIKit

enum AppTab: Int, CaseIterable, Identifiable, Hashable {
   
    case today
    case calendar
    case client
    case payouts
    case profile
    
    var id: Int { rawValue }

}

struct ContentView: View {
    
    @available(iOS 26.0, *)
    private var tabs: [FabBarTab<AppTab>] {
        let allTabs: [FabBarTab<AppTab>] = [
            FabBarTab(value: .today, title: "today", image: "TodayTabIcon", onReselect: {
          
            }),
            FabBarTab(value: .calendar, title: "august", image: "CalendarTabIcon", onReselect: {
                
            }),
            FabBarTab(value: .client, title: "client", image: "ClientTabIcon", onReselect: {
               
            }),
            FabBarTab(value: .payouts, title: "payouts", image: "PayloadsTabIcons", onReselect: {

            }),
        ]
        return Array(allTabs)
    }
    @State private var selected: AppTab = .calendar
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    private var tabBarVisibility: Visibility {

        return horizontalSizeClass == .compact ? .hidden : .visible
    }
    var body: some View {
       
        if #available(iOS 26.0, *) {
            TabView(selection: $selected) {
                
                Tab("today", image: "TodayTabIcon", value: AppTab.today) {
                    TodayView()
                        .toolbarVisibility(tabBarVisibility, for: .tabBar)
                }
                Tab("august", image: "CalendarTabIcon", value: AppTab.calendar) {
                    CalendarView()
                        .environmentObject(CalendarManager.shared)
                        .toolbarVisibility(tabBarVisibility, for: .tabBar)
                }
                Tab("client", image: "ClientTabIcon", value: AppTab.client) {
                    ClientsView()
                        .toolbarVisibility(tabBarVisibility, for: .tabBar)
                }
                Tab("payouts", image: "PayloadsTabIcons", value: AppTab.payouts) {
                    PayoutsView()
                        .toolbarVisibility(tabBarVisibility, for: .tabBar)
                }
            } .fabBar(
                selection: $selected,
                tabs: tabs,
                action: FabBarAction(
                    image: .profileThumd,
                    accessibilityLabel: "profile"
                ) {
                    
                })
        } else {
            TabView(selection: $selected) {
                TodayView()
                    .tabItem {
                        Label("today", image: "TodayTabIcon")
                    }
                    .tag(AppTab.today)
                
                CalendarView()
                    .environmentObject(CalendarManager.shared)
                    .tabItem {
                        Label("august", image: "CalendarTabIcon")
                    }
                    .tag(AppTab.calendar)
                
                ClientsView()
                    .tabItem {
                        Label("client", image: "ClientTabIcon")
                    }
                    .tag(AppTab.client)
                
                PayoutsView()
                    .tabItem {
                        Label("payouts", image: "PayloadsTabIcons")
                    }
                    .tag(AppTab.payouts)
            }
        }
    }
}

#Preview {
    ContentView()
}
