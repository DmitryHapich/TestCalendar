//
//  CalendarView.swift
//  TestCalendar
//
//  Created by Dima H on 13.04.2026.
//

import SwiftUI

struct CalendarView: View {
    
    @EnvironmentObject var calendarManager: CalendarManager
    
    private var days: [WeekDay] {
        
        return [Date.now.appendDay(-3),
                Date.now.appendDay(-2),
                Date.now.appendDay(-1),
                Date.now,
                Date.now.appendDay(1),
                Date.now.appendDay(2),
                Date.now.appendDay(3)].map { day in
            
            if calendarManager.dayOffs.contains([day.startOfDay]) {
                return WeekDay(date: day, badge: .dayOff)
            } else {
                
                let count = Appointment.mock.filter {$0.date.startOfDay == day.startOfDay }.count
                return WeekDay(date: day, badge: .count(count))
            }
        }
    }
    private var appointments: [Appointment] {
        
        return Appointment.mock.filter {$0.date.startOfDay == selectDay.startOfDay }
    }
    
    private var barberName: String = "malik"
    private var dayOffMessage: String {
        
        selectDay.startOfDay == calendarManager.today ? "hope it will be a good one \(barberName)" : "enjoy your day off!"
    }
    
    @State private var isLoading = true
    @State private var isEmpty = false
    @State private var isDayOff = false
    @State private var isError = false
    @State private var now = Date.now
    @State private var selectDay = Date.now
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.tcSurface.ignoresSafeArea()
            
            VStack() {
                
                if isLoading {
                    CalendarLoadingView()
                } else {
                    if !isError {
                        CalendarHeaderView(selectDay: $selectDay, days: days)
                            .padding(.horizontal, 16)
                        if isEmpty {
                            HStack() {
                                Image(.emptyCalendarIcon)
                                Text("nothing booked yet")
                                    .font(.enkel(size: 12).weight(.semibold))
                                    .foregroundColor(.tcTimeLabel)
                            }
                        }
                        if !isDayOff {
                            
                            timelineScrollView
                            
                        } else {
                            CalendarDayOffView(message: dayOffMessage)
                        }
                        
                    } else {
                        CalendarErrorView() {
                            isLoading = true
                            isError = false
                            selectDay = Date.now
                        }
                    }
                }
            }
            .onChange(of: selectDay) { oldValue, newValue in
                withAnimation(.easeInOut(duration: 0.3)) {
                    isDayOff = calendarManager.dayOffs.contains([newValue.startOfDay])
                    isEmpty = appointments.isEmpty && !isDayOff
                    
                    if newValue.startOfDay == days.last!.date.startOfDay {
                        isError = true
                    }
                }
            }
            .task {
                isDayOff = calendarManager.dayOffs.contains([selectDay.startOfDay])
                isEmpty = appointments.isEmpty && !isDayOff
                Task.detached {
                    try? await Task.sleep(for: .seconds(3))
                    await MainActor.run {
                        isLoading = false
                    }
                }
            }
        }
    }

    private var timelineScrollView: some View {
        
        ScrollViewReader { proxy in
            ScrollView(showsIndicators: false) {
                GeometryReader { geometry in
                    ZStack(alignment: .topLeading) {
                        Color.tcSurface.ignoresSafeArea()
                        // Hour guide lines
                        ForEach(TC.startHour..<TC.endHour, id: \.self) { hour in
                            TimelineHourRow(hour: hour)
                                .offset(y: TC.y(hour: hour))
                                .padding(.horizontal,16)
                                .id(hour)
                        }
                        
                        // Appointment cards
                            ForEach(appointments) { apt in
                                AppointmentCard(apt: apt)
                                    .offset(y: TC.y(hour: apt.hour, minute: apt.minute))
                                    .offset(x: column(for: apt).xOffset(for:geometry.size.width))
                                    .frame(width: column(for: apt).width(for: geometry.size.width))
                            }
                        
                        if selectDay.startOfDay == calendarManager.today.startOfDay {
                            // Current time indicator
                            CurrentTimeBar(date: $now)
                                .offset(y: TC.y(hour: now.hourInt, minute: now.minuteInt))
                                .id("currentTime")
                        }
                    }
                    .padding(.top, 11)
                }
                .frame(height: TC.totalHeight )
            }
            .onChange(of: selectDay) { oldValue, newValue in
                withAnimation(.easeInOut(duration: 0.3)) {
                    
                    if newValue.startOfDay == now.startOfDay {
                        proxy.scrollTo("currentTime", anchor: .center)
                    } else {
                        proxy.scrollTo(TC.startHour, anchor: .center)
                    }
                }
            }
        }
    }
    
    private func column(for apt: Appointment) -> CardColumn {
        
        guard let index = appointments.firstIndex(of: apt) else {
            return .full
        }
        
        let overlapsWithNext: Bool = {
            guard index + 1 < appointments.count else { return false }
            let nextApt = appointments[index + 1]
            return apt.endDate > nextApt.date
        }()
        
        let overlapsWithPrev: Bool = {
            guard index > 0 else { return false }
            let prevApt = appointments[index - 1]
            return prevApt.endDate > apt.date
        }()
        
        guard overlapsWithNext || overlapsWithPrev else {
            return .full
        }
        
        if overlapsWithPrev {
            let prevColumn = column(for: appointments[index - 1])
            switch prevColumn {
            case .left:
                return .right
            case .right:
                return .left
            case .full:
                return .left
            }
        }
        
        return .left
    }
}

#Preview {
    CalendarView()
        .environmentObject(CalendarManager.shared)
}
