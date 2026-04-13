//
//  CurrentTimeBar.swift
//  TestCalendar
//
//  Created by Dima H on 13.04.2026.
//

import SwiftUI

struct CurrentTimeBar: View {
    
   @Binding var date: Date

    private var label: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mma"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: date).lowercased()
//        return date.formatted(.dateTime.hour(.defaultDigits(amPM: .abbreviated)).minute()).lowercased()
    }

    var body: some View {
        HStack(spacing: 0) {
            Text(label)
                .font(.enkel(size: 10).weight(.semibold))
                .tracking(0.8)
                .foregroundColor(.tcGreenDark)
                .frame(width: 64)
                .padding(.vertical, 4)
                .background(Color.tcGreen)
                .clipShape(Capsule())

            Rectangle()
                .fill(Color.tcGreen)
                .frame(height: 2)
        }
        .padding(.top, -11)
    }
}
