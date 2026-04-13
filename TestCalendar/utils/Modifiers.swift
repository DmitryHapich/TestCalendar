//
//  Modifiers.swift
//  TestCalendar
//
//  Created by Dima H on 13.04.2026.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        
        if #available(iOS 26.0, *) {
            configuration.label
                .font(Font.enkel(size: 14).weight(.bold))
                .foregroundColor(.tcCalTitle)
                .padding(.horizontal, 24)
                .frame(height: 40)
                .background(RoundedRectangle(cornerRadius: 20).fill(.tcMenuBG))
                .glassEffect()
            
        } else {
            
            configuration.label
                .font(Font.enkel(size: 14).weight(.bold))
                .foregroundColor(.tcCalTitle)
                .padding(.horizontal, 24)
                .frame(height: 40)
                .background(RoundedRectangle(cornerRadius: 20).fill(.tcMenuBG))
        }
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Font.enkel(size: 14).weight(.bold))
            .foregroundColor(.tcClientActive)
            .frame(height: 44)
            .padding(.horizontal, 24)
            .background(.tcSecondary)
            .clipShape(Capsule())
    }
}

struct WhiteButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Font.enkel(size: 14).weight(.bold))
            .foregroundColor(.tcSurface)
            .frame(height: 44)
            .padding(.horizontal, 24)
            .background(.tcButtonBG)
            .clipShape(Capsule())
    }
}


struct Pill: ViewModifier {
    
    let color: Color
    init(color: Color = .white) {
        self.color = color
    }
    
    func body(content: Content) -> some View {
        content
            .font(.enkel(size: 10).weight(.bold))
            .tracking(0.1)
            .foregroundColor(color)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .overlay(Capsule().stroke(color, lineWidth: 0.5))
    }
}

public extension View {
    
    func skeleton<S>(_ shape: S? = nil as Rectangle?, color: Color = Color.gray.opacity(0.3), isLoading: Bool) -> some View where S: Shape {
        guard isLoading else { return AnyView (self) }
        
        let skeletonShape: AnyShape = if let shape {
            AnyShape (shape)
        } else {
            AnyShape (Rectangle())
        }
        return AnyView(
            opacity(0)
                .background(skeletonShape.fill(color))
                .shimmering()
        )
        
    }
    func shimmering() -> some View {
        modifier(ShimmeringModifier())
    }
}

struct ShimmeringModifier: ViewModifier {
    
    @State private var phase: CGFloat = 0
    
    public func body (content: Content) -> some View {
        content
            .modifier(AnimatedMask(phase: phase))
            .onAppear {
                withAnimation(
                    .linear(duration: 2)
                    .repeatForever (autoreverses: false)
                ) {
                    phase = 1
                }
            }
    }
}

struct AnimatedMask: AnimatableModifier {
    
    var phase: CGFloat
    var animatableData: CGFloat {
        get { phase }
        set { phase = newValue }
    }
    
    func body (content: Content) -> some View {
        content
            .mask(
                GradientMask(phase: phase)
                    .scaleEffect (3)
            )
    }
}

struct GradientMask: View {
    let phase: CGFloat
    let centerColor = Color.black.opacity(0.5)
    let edgecolor = Color.black.opacity(1)
    
    var body: some View {
        GeometryReader { geometry in
            LinearGradient (gradient:
                                Gradient (
                                    stops: [
                                        .init(color: edgecolor, location: phase),
                                        .init(color: centerColor, location: phase + 0.1),
                                        .init(color: edgecolor, location: phase + 0.2)
                                    ]
                                ),
                            startPoint: UnitPoint (x: 0, y: 0.5),
                            endPoint: UnitPoint (x: 1, y: 0.5)
            )
            .rotationEffect(.degrees (-45))
            .offset (x: -geometry.size.width, y: -geometry.size.height)
            .frame (width: geometry.size.width * 3, height: geometry.size.height * 3)
        }
    }
}
