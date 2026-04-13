//
//  TimelineHourRow.swift
//  TestCalendar
//
//  Created by Dima H on 13.04.2026.
//

import SwiftUI

struct TimelineHourRow: View {
    let hour: Int

    private var hourNumber: String {
        let h = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour)
        return "\(h)"
    }
    private var ampm: String { hour < 12 ? "am" : "pm" }

    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            
            HStack(alignment: .firstTextBaseline, spacing: 2) {
                Text(hourNumber)
                    .font(.enkel(size: 18).weight(.semibold))
                    .tracking(-0.18)
                    .foregroundColor(.tcTimeLabel)
                Text(ampm)
                    .font(.enkel(size: 12).weight(.medium))
                    .tracking(-0.12)
                    .foregroundColor(.tcTimeFormat)
                    .padding(.top, 3)
            }
            .frame(width: 40)
            
            GeometryReader { geometry in
                Path { path in
                    path.move(to: CGPoint(x: 0, y: 0))
                    path.addLine(to: CGPoint(x: geometry.size.width, y: 0))
                }
                .stroke(style: StrokeStyle(lineWidth: 1, dash: [4, 4]))
                .foregroundColor(.tcTimeLine)
            }
            .frame(height: 1)
        }
        .padding(.top, -12)
    }
}
