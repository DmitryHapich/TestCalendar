//
//  CalendarErrorView.swift
//  TestCalendar
//
//  Created by Dima H on 13.04.2026.
//

import SwiftUI

struct CalendarErrorView: View {
    var message: String = "check your connection and try again"
    var onTryAgain: (() -> Void)? = nil

    var body: some View {
        ZStack {
            Color.tcSurface.ignoresSafeArea()

            VStack(spacing: 24) {
                VStack(alignment: .center, spacing: 12) {
                    Text("something went wrong")
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

                Button(action: { onTryAgain?() }) {
                    Text("try again")
                }
                .buttonStyle(WhiteButtonStyle())
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    CalendarErrorView()
}
