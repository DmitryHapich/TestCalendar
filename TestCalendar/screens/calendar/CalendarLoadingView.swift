//
//  CalendarLoadingView.swift
//  TestCalendar
//
//  Created by Dima H on 13.04.2026.
//

import SwiftUI

// MARK: - Calendar Loading View (skeleton state)

struct CalendarLoadingView: View {
    
   @State var isLoading = true
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.tcSurface.ignoresSafeArea()

            VStack(){
                
                skeletonHeader
                skeletonScrollView
            }
        }
    }

    // MARK: Skeleton Header

    private var skeletonHeader: some View {
        VStack(alignment: .leading, spacing: 14) {
            // Month title placeholder + button placeholder
            HStack {
                RoundedRectangle(cornerRadius: 100)
                    .fill(Color.tcLoaderBG)
                    .frame(width: 94, height: 36)
                Spacer()
                RoundedRectangle(cornerRadius: 100)
                    .fill(Color.tcLoaderBG)
                    .frame(width: 40, height: 40)
            }

            // Week strip placeholders
            HStack(spacing: 4) {
                ForEach(0..<7, id: \.self) { i in
                    RoundedRectangle(cornerRadius: 12)
                        .fill(i == 3 ? Color.tcLoaderBG : Color.tcLoaderBG2)
                        .frame(width: 48, height: 68)
                        .skeleton(color: i == 3 ? Color.tcLoaderBG : Color.tcLoaderBG2, isLoading: isLoading)
                        .cornerRadius(12)
                }
            }
        }
        .padding(.horizontal, 16)
        .background(Color.tcSurface)
    }

    // MARK: Skeleton Timeline

    private var headerHeight: CGFloat { 208 }
    private var menuHeight: CGFloat   {  94 }

    private var skeletonScrollView: some View {
        ScrollView(showsIndicators: false) {
            ZStack(alignment: .topLeading) {
                Color.clear

                ForEach([0, 1, 2, 3], id: \.self) { slot in
                    RoundedRectangle(cornerRadius: 100)
                        .fill(Color.tcLoaderBG2)
                        .frame(width: 40, height: 18)
                        .skeleton(color: .tcLoaderBG, isLoading: isLoading)
                        .cornerRadius(100)
                        .offset(x: 16, y: TC.y(hour: TC.startHour + slot))
                }

                // Appointment card skeletons
                SkeletonCard(width: TC.fullCardWidth, height: 140, nameWidth: 87, serviceWidth: 69)
                    .offset(x: CardColumn.cardLeft, y: TC.y(hour: 9, minute: 30))

                SkeletonCard(width: TC.fullCardWidth, height: 104, nameWidth: 75, serviceWidth: 85)
                    .offset(x: CardColumn.cardLeft, y: TC.y(hour: 10, minute: 45))

                SkeletonCard(width: TC.fullCardWidth, height: 104, nameWidth: 69, serviceWidth: 104)
                    .offset(x: CardColumn.cardLeft, y: TC.y(hour: 12))

            }
        }
    }
}

// MARK: - Skeleton Card

private struct SkeletonCard: View {
    
    let width: CGFloat
    let height: CGFloat
    let nameWidth: CGFloat
    let serviceWidth: CGFloat
    @State var isLoading = true
    
    var body: some View {
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 12)
                .skeleton(color: .tcLoaderBG2, isLoading: isLoading)
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    RoundedRectangle(cornerRadius: 100)
                        .fill(.tcLoaderBG)
                        .frame(width: nameWidth, height: 16)
                        .skeleton(color: .tcLoaderBG, isLoading: isLoading)
                        .cornerRadius(100)
                    Spacer()
                    RoundedRectangle(cornerRadius: 100)
                        .fill(.red)
                        .frame(width: 52, height: 16)
                        .skeleton(color: .tcLoaderBG, isLoading: isLoading)
                        .cornerRadius(100)
                }
                RoundedRectangle(cornerRadius: 100)
                    .fill(.tcLoaderBG)
                    .frame(width: serviceWidth, height: 16)
                    .skeleton(color: .tcLoaderBG, isLoading: isLoading)
                    .cornerRadius(100)
            }
            .padding(12)
        }
        .frame(width: width, height: height, alignment: .topLeading)
        .background(Color.black)
        .cornerRadius(12)
        
    }
}

#Preview {
    CalendarLoadingView()
}
