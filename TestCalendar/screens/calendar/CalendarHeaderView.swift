//
//  CalendarHeaderView.swift
//  TestCalendar
//
//  Created by Dima H on 13.04.2026.
//

import SwiftUI

struct CalendarHeaderView: View {

    @EnvironmentObject var calendarManager: CalendarManager
    @Binding var selectDay: Date
    var month: String {
        calendarManager.today.formatted(.dateTime.month(.wide)).lowercased()
    }
    
    let days: [WeekDay]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            
            HStack(alignment: .center) {
                Text(month)
                    .font(.enkel(size: 32).weight(.bold))
                    .tracking(-0.32)
                    .foregroundColor(.tcH1)

                Spacer()
                if selectDay.startOfDay != calendarManager.today.startOfDay {
                    Button {
                        selectDay = calendarManager.today
                    }
                    label: {
                        Text("today")
                    }
                    .buttonStyle(PrimaryButtonStyle())
                }
                Button {
                    
                } label: {
                    Image(.chevronDown)
                        .foregroundColor(.tcCalTitle)
                        .frame(width: 40, height: 40)
                }
                .background {
                    if #available(iOS 26.0, *) {
                        Circle()
                            .fill(Color.tcMenuBG)
                            .glassEffect()
                    } else {
                        Circle()
                            .fill(Color.tcMenuBG)
                    }
                }
                
            }
            
            HStack(alignment: .center, spacing: 4) {
                ForEach(days) { day in
                    WeekDayCell(day: day) {
                        if day.date.startOfDay >= calendarManager.today.startOfDay {
                            selectDay = day.date
                        }
                    }
                        .overlay(
                            Group {
                                if day.date.startOfDay == selectDay.startOfDay  {
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.tcCalOutline, lineWidth: 1.2)
                                }
                            }
                        )
                }
            }
        }
        .background(Color.tcSurface)
    }
}

#Preview {
    @Previewable @State var selectDay: Date = Date.now
    ZStack(alignment: .top) {
        Color.tcSurface.ignoresSafeArea()
        CalendarHeaderView(selectDay: $selectDay, days: WeekDay.mock)
            .environmentObject(CalendarManager.shared)
            .padding(.horizontal, 16)
    }
}
