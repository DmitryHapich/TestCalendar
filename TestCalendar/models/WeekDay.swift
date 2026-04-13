//
//  WeekDay.swift
//  TestCalendar
//
//  Created by Dima H on 13.04.2026.
//

import Foundation

enum WeekBadge {
    case count(Int)
    case dayOff
}

struct WeekDay: Identifiable {
    var id: String { "\(date.startOfDay)" }
    let date: Date
    let badge: WeekBadge
}

extension WeekDay {
    
    static let mock: [WeekDay] = [
        WeekDay(date: Date.now.appendDay(-3), badge: .count(16)),
        WeekDay(date: Date.now.appendDay(-2), badge: .dayOff),
        WeekDay(date: Date.now.appendDay(-1), badge: .count(14)),
        WeekDay(date: Date.now,               badge: .count(12)),
        WeekDay(date: Date.now.appendDay(1),  badge: .count(9)),
        WeekDay(date: Date.now.appendDay(2),  badge: .dayOff),
        WeekDay(date: Date.now.appendDay(3),  badge: .count(6)),
    ]
}
