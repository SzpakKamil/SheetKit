//
//  SKStepperMACOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 01/08/2025.
//

import SwiftUI

#if os(macOS)
struct SKStepperMACOS<S: Strideable>: View, SKComponent {
    @Environment(\.colorScheme) var colorScheme
    public let type: SKComponentType = .field
    @Environment(\.skRowShape) var skRowShape
    @Environment(\.skIsInSection) var skIsInSection
    @Environment(\.skRowBackgroundColor) var skRowBackgroundColor
    var data: SKStepper<S>.Data
    var autoBackgroundColor: Color{
        if let skRowBackgroundColor{
            return skRowBackgroundColor
        }else{
            return .clear
        }
    }
    public var body: some View {
        HStack(spacing: 0){
            Text("\(data.title): \(data.textForValue(data.value.wrappedValue))")
                .contentTransition(.numericText())
                .animation(.smooth, value: data.value.wrappedValue)
            Spacer()
            if let range = data.range{
                Stepper("", value: data.value, in: range, step: data.step)
                    .labelsHidden()
                    .scaleEffect(0.75)
            }else{
                Stepper("", value: data.value, step: data.step)
                    .labelsHidden()
                    .scaleEffect(0.75)
            }
        }
        .padding(.leading, 6)
        .padding(.trailing, 0.1)
        .padding(.vertical, -1)
        .background(autoBackgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: skIsInSection ? 0 : skRowShape ?? 6, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: skRowShape ?? 6, style: .continuous)
                .stroke(.primary.opacity(0.06), lineWidth: skIsInSection ? 0 : 1)
        )
        .contentShape(Rectangle())
    }
    
    public init(data: SKStepper<S>.Data) {
        self.data = data
    }
}

#if DEBUG
#Preview {
    PreviewViewSKStepper()
}
#endif
#endif
