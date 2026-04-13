//
//  WeekDayCell.swift
//  TestCalendar
//
//  Created by Dima H on 13.04.2026.
//

import Foundation
import SwiftUI

struct WeekDayCell: View {
    
    @EnvironmentObject var calendarManager: CalendarManager
    let day: WeekDay
    var onTap: (() -> Void)? = nil
    
    private  var textColor: Color { isPast ? .tcCalTitle3 : .tcCalTitle }
    private var badgeColor: Color { isPast ? .tcCalTitle4 : .tcCalTitle2 }

    private var isPast: Bool {
        day.date.startOfDay < calendarManager.today.startOfDay
    }
    private var dayName: String {
        day.date.formatted(.dateTime.weekday(.short))
    }
    private  var dayNumber: String {
        day.date.formatted(.dateTime.day())
    }
    
    var body: some View {
        Button {
            onTap?()
        } label: {
            VStack(spacing: 6) {
                Text(dayName.uppercased())
                    .font(.enkel(size: 9).weight(.medium))
                    .tracking(0.9)
                    .foregroundColor(textColor)
                
                Text(dayNumber)
                    .font(.enkel(size: 14).weight(.bold))
                    .tracking(-0.14)
                    .foregroundColor(textColor)
                
                switch day.badge {
                case .count(let n):
                    Text("\(n)")
                        .font(.enkel(size: 9).weight(.medium))
                        .tracking(0.9)
                        .foregroundColor(badgeColor)
                case .dayOff:
                    Image(.dayOffIcon)
                        .font(.system(size: 8))
                        .foregroundColor(badgeColor)
                }
            }
            .frame(width: 48)
            .padding(.vertical, 10)
            .background(Color.tcSurface)
            .cornerRadius(12)
        }
        .disabled(isPast)
    }
}
#Preview {
    ZStack(alignment: .center) {
        Color.tcSurface.ignoresSafeArea()
        WeekDayCell(day: WeekDay.mock[5])
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.tcCalOutline , lineWidth: 1.2)
            ) .environmentObject(CalendarManager.shared)
    }
}
