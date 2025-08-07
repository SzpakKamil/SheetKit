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
    var data: SKStepper<S>.Data
    var autoBackgroundColor: Color{
        if let backgroundColor = data.backgroundColor{
            return backgroundColor
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
            Stepper("\(data.title): \(data.textForValue(data.value.wrappedValue))", value: data.value, in: data.range, step: data.step)
                .labelsHidden()
                .scaleEffect(0.75)
        }
        .padding(.leading, 6)
        .padding(.trailing, 0.1)
        .padding(.vertical, -1)
        .background(autoBackgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: data.cornerRadius ?? 6, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: data.cornerRadius ?? 6, style: .continuous)
                .stroke(.primary.opacity(0.06), lineWidth: 1)
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
