//
//  Date+ext.swift
//  TestCalendar
//
//  Created by Dima H on 13.04.2026.
//

import Foundation

extension Date {
    
    static var firstDayOfWeek = Calendar.current.firstWeekday
    
    static var capitalizedFirstLettersOfWeekdays: [String] {
        let calendar = Calendar.current
        var weekdays = calendar.shortWeekdaySymbols
        if firstDayOfWeek > 1 {
            for _ in 1..<firstDayOfWeek {
                if let first = weekdays.first {
                    weekdays.append(first)
                    weekdays.removeFirst()
                }
            }
        }
        return weekdays.map { $0.capitalized }
    }

    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
    
    var startOfMonth: Date {
        Calendar.current.dateInterval(of: .month, for: self)!.start
    }

    var endOfMonth: Date {
        let lastDay = Calendar.current.dateInterval(of: .month, for: self)!.end
        return Calendar.current.date(byAdding: .day, value: -1, to: lastDay)!
    }

    var numberOfDaysInMonth: Int {
        Calendar.current.component(.day, from: endOfMonth)
    }

    var firstWeekDayBeforeStart: Date {
       let startOfMonthWeekday = Calendar.current.component(.weekday, from: startOfMonth)
       var numberFromPreviousMonth = startOfMonthWeekday - Self.firstDayOfWeek
       if numberFromPreviousMonth < 0 {
           numberFromPreviousMonth += 7
       }
       return Calendar.current.date(byAdding: .day, value: -numberFromPreviousMonth, to: startOfMonth)!
    }
    
    var calendarDisplayDays: [Date] {
       var days: [Date] = []
        
       let firstDisplayDay = firstWeekDayBeforeStart
       var day = firstDisplayDay
       while day < startOfMonth {
           days.append(day)
           day = Calendar.current.date(byAdding: .day, value: 1, to: day)!
       }
        
       for dayOffset in 0..<numberOfDaysInMonth {
           if let newDay = Calendar.current.date(byAdding: .day, value: dayOffset, to: startOfMonth) {
               days.append(newDay)
           }
       }
        
        var numday = 6 - Calendar.current.component(.weekday, from: endOfMonth) + Self.firstDayOfWeek
        day = Calendar.current.date(byAdding: .day, value: 1, to: endOfMonth)!
        while numday > 0 && numday != 7 {
            days.append(day)
            day = Calendar.current.date(byAdding: .day, value: 1, to: day)!
            numday -= 1
        }
       return days
    }

    var dayInt: Int {
        Calendar.current.component(.day, from: self)
    }
    var monthInt: Int {
        Calendar.current.component(.month, from: self)
    }

    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }

    var hourInt: Int {
        Calendar.current.component(.hour, from: self)
    }

    var minuteInt: Int {
        Calendar.current.component(.minute, from: self)
    }

    var formattedDate: String {
        let formatter = ISO8601DateFormatter()
        formatter.timeZone = .current
        formatter.formatOptions = [.withFullDate]
        return formatter.string(from: self)
    }

    var formattedDateHourCombined: String {
        let formatter = ISO8601DateFormatter()
        formatter.timeZone = .current
        return formatter.string(from: self)
    }
    
    func isDate(start: Date, and end: Date) -> Bool {
        let lower = min(start, end)
        let upper = max(start, end)
        return (lower...upper).contains(self)
    }
    
    func append(by component: Calendar.Component = .day, _ value: Int)  -> Date {
        Calendar.current.date(byAdding: component, value: value, to: self)!
    }
    
    func appendDay( _ value: Int)  -> Date {
        Calendar.current.date(byAdding: .day, value: value, to: self.startOfDay)!
    }
    
    func days(to date: Date) -> Int {
        
        return Calendar.current.dateComponents([.day], from: self.startOfDay, to: date.startOfDay).day ?? 0
    }
    
    func months(to date: Date) -> Int {
        let components = Calendar.current.dateComponents([.month], from: self, to: date)
        return components.month ?? 0
    }
    
    func hours(to date: Date) -> Double {
        
       return date.timeIntervalSince(self) / 3600
    }
}
