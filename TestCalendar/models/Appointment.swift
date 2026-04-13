//
//  Appointment.swift
//  TestCalendar
//
//  Created by Dima H on 13.04.2026.
//

import Foundation

struct Appointment: Identifiable, Equatable {
    
    let id = UUID()
    let clientName: String
    let date: Date
    let duration: Int
    let services: [Services]
    var status: Status = .none
    
    static func == (lhs: Appointment, rhs: Appointment) -> Bool {
        lhs.id == rhs.id
    }
    
    var endDate: Date {
        date.append(by: .minute, duration)
    }
    
    var hour: Int {
        Calendar.current.component(.hour, from: date)
    }
    
    var minute: Int {
        Calendar.current.component(.minute, from: date)
    }
    
    enum Status {
        case none, noCard, paymentFailed
    }

    enum State {
        case past, upcoming
    }
    
    enum Services: String {
        
        case buzz_cut = "buzz cut"
        case line_up = "line up"
        case hair_wash = "hair wash"
        case beard_trim = "beard trim"
        case razor_lineup = "razor lineup"
        case skin_fade = "skin fade"
    }
}


