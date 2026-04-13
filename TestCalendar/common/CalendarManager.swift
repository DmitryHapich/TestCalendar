//
//  CalendarManager.swift
//  TestCalendar
//
//  Created by Dima H on 13.04.2026.
//

import Combine
import Foundation

class CalendarManager: ObservableObject {
    
    static let shared = CalendarManager()
    
    let hasUpdate = PassthroughSubject<Bool, Never>()
    
    @Published var today: Date = Date.now.startOfDay
//    var dayOffs: [Date] = [Date.now.appendDay(-2).startOfDay, Date.now.appendDay(2).startOfDay]
    var dayOffs: [Date] = [Date.now.startOfDay,Date.now.appendDay(-2).startOfDay, Date.now.appendDay(2).startOfDay]

}

extension Appointment {
    
    static let mock: [Appointment] = {
        let calendar = Calendar.current
        let today = Date.now
        
        func makeDate(hour: Int, minute: Int) -> Date {
            var components = calendar.dateComponents([.year, .month, .day], from: today)
            components.day! += 1
            components.hour = hour
            components.minute = minute
            return calendar.date(from: components) ?? today
        }
        
        return [
            Appointment(clientName: "darius king",    date: makeDate(hour: 9, minute: 0),   duration: 40, services: [.buzz_cut]),
            Appointment(clientName: "omar hassan",    date: makeDate(hour: 9, minute: 30),  duration: 40, services: [.line_up, .hair_wash]),
            Appointment(clientName: "alex rivera",    date: makeDate(hour: 10, minute: 30), duration: 60, services: [.line_up, .beard_trim, .razor_lineup], status: .paymentFailed),
            Appointment(clientName: "andre phillips", date: makeDate(hour: 12, minute: 0),  duration: 50, services: [.line_up, .beard_trim, .razor_lineup]),
            Appointment(clientName: "marcus lee",     date: makeDate(hour: 12, minute: 30), duration: 60, services: [.buzz_cut, .beard_trim, .razor_lineup], status: .paymentFailed),
            Appointment(clientName: "john jones jr.", date: makeDate(hour: 13, minute: 15), duration: 40, services: [.buzz_cut]),

            Appointment(clientName: "tony martinez",  date: makeDate(hour: 14, minute: 45), duration: 60, services: [.line_up, .beard_trim, .razor_lineup]),
            Appointment(clientName: "james carter",   date: makeDate(hour: 15, minute: 30), duration: 45, services: [.skin_fade, .beard_trim]),
            Appointment(clientName: "dacid wright",   date: makeDate(hour: 17, minute: 0),  duration: 20, services: [], status: .noCard),
            Appointment(clientName: "john jones jr.", date: makeDate(hour: 17, minute: 20), duration: 40, services: [.line_up, .beard_trim, .razor_lineup], status: .noCard),
        ]
    }()
}
