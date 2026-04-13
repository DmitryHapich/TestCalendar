//
//  CalendarDayOffView.swift
//  TestCalendar
//
//  Created by Dima H on 13.04.2026.
//

import SwiftUI

// MARK: - Calendar Day Off View

struct CalendarDayOffView: View {
    var message: String = "hope it will be a good one malik"
    var onUpdateHours: (() -> Void)? = nil

    var body: some View {
        ZStack {
            Color.tcSurface.ignoresSafeArea()

            VStack(spacing: 24) {
                VStack(alignment: .center, spacing: 12) {
                    Text("day off")
                        .font(.enkel(size: 24).weight(.bold))
                        .tracking(-0.48)
                        .foregroundColor(.tcH1)
                        .frame(maxWidth: .infinity, alignment: .center)

                    Text(message)
                        .font(.enkel(size: 14).weight(.medium))
                        .tracking(-0.14)
                        .foregroundColor(Color(hex: "929292"))
                        .frame(maxWidth: .infinity, alignment: .center)
                }

                Button(action: { onUpdateHours?() }) {
                    Text("update hours")
                }
                .buttonStyle(SecondaryButtonStyle())
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    CalendarDayOffView()
}
