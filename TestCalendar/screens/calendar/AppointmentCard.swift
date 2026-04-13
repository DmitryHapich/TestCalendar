//
//  AppointmentCard.swift
//  TestCalendar
//
//  Created by Dima H on 13.04.2026.
//

import SwiftUI

struct AppointmentCard: View {
    
    let apt: Appointment
  
    
    private var cardBG: Color     { isPast    ? .tcCardPast      : .tcCardActive }
    private var clientColor: Color { isPast   ? .tcClientPast    : .tcClientActive }
    private var timeNumColor: Color { isPast  ? .tcTimeNumPast   : .tcTimeNumActive }
    private var timeAmPmColor: Color { isPast ? .tcTimeAmPmPast  : .tcTimeAmPmActive }
    private var serviceColor: Color { isPast  ? .tcServicePast   : .tcServiceActive }
    private var statusColor: Color { isPast   ? .tcIssueInactive : .tcIssue }

    private var isPast:  Bool {
        apt.date < Date.now
    }
    
    private var timeNumber: String {
        let h = apt.hour > 12 ? apt.hour - 12 : apt.hour
        if apt.minute == 0 { return "\(h)" }
        return "\(h):\(String(format: "%02d", apt.minute))"
    }
    
    private var timeAmPm: String { apt.hour < 12 ? "am" : "pm" }
    
    private var cardHeight: CGFloat {
        return CGFloat(apt.duration) * TC.pixelsPerMinute - CardColumn.margin
    }
    
    private var services: String {
       
        apt.services.map{ $0.rawValue }.joined(separator: " • ")
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            
            HStack(alignment: .center, spacing: 4) {
                Text(apt.clientName.lowercased())
                    .font(.enkel(size: 14).weight(.bold))
                    .tracking(0.28)
                    .foregroundColor(clientColor)
                    .lineLimit(1)

                if apt.status == .noCard {
                    Text("no card")
                        .modifier(Pill(color: statusColor))
                }

                Spacer(minLength: 4)

                HStack(alignment: .bottom, spacing: 2) {
                    Text(timeNumber)
                        .font(.enkel(size: 16).weight(.medium))
                        .tracking(-0.48)
                        .foregroundColor(timeNumColor)
                    Text(timeAmPm)
                        .font(.enkel(size: 12).weight(.medium))
                        .tracking(-0.12)
                        .foregroundColor(timeAmPmColor)
                        .frame(height: 14, alignment: .bottom)
                }
            }

            if !services.isEmpty {
                Text(services)
                    .font(.enkel(size: 10).weight(.semibold))
                    .tracking(0.8)
                    .foregroundColor(serviceColor)
                    .lineLimit(3)
            }
            Spacer()
            
            if apt.status == .paymentFailed {
                Text("payment failed")
                    .modifier(Pill(color: statusColor))
            }
        }
        .padding(12)
        .background(cardBG)
        .frame(height: cardHeight, alignment: .topLeading)
        .cornerRadius(12)
    }
}


#Preview {
    VStack(){
        Spacer()
        AppointmentCard(apt: Appointment.mock[0])
        AppointmentCard(apt: Appointment.mock[1])
        AppointmentCard(apt: Appointment.mock[8])
        AppointmentCard(apt: Appointment.mock[9])
            .padding(.horizontal,100)
        Spacer()
    }
    .background(.tcSurface)
    
}
