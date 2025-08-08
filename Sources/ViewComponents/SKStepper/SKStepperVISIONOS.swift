//
//  SKStepperVISIONOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 01/08/2025.
//

import SwiftUI

#if os(visionOS)
struct SKStepperVISIONOS<S: Strideable>: View, SKComponent {

    @Environment(\.colorScheme) var colorScheme
    public let type: SKComponentType = .field
    var data: SKStepper<S>.Data
    var autoBackgroundColor: Color{
        if let backgroundColor = data.backgroundColor{
            return backgroundColor
        }else{
            if colorScheme == .dark{
                return Color(red: 0.1647058824, green: 0.1647058824, blue: 0.1764705882)
            }else{
                return .white
            }
        }
    }
    public var body: some View {
        HStack(spacing: 0){
            Text("\(data.title): \(data.textForValue(data.value.wrappedValue))")
            Spacer()
            HStack(spacing: 8){
                let isIncrementDisabled = data.value.wrappedValue >= data.range.upperBound
                let isDecrementDisabled = data.value.wrappedValue <= data.range.lowerBound
                Button{
                    let newValue = data.value.wrappedValue.advanced(by: data.step)
                    data.value.wrappedValue = min(newValue, data.range.upperBound)
                }label:{
                    Image(systemName: "plus")
                }
                .buttonRepeatBehavior(.enabled)
                .disabled(isIncrementDisabled)
                .opacity(isIncrementDisabled ? 0.5 : 1)
                .foregroundStyle(.primary)
                .buttonBorderShape(.circle)
                .accessibilityLabel("Increment \(data.title)")
                
                Button{
                    let newValue = data.value.wrappedValue.advanced(by: -data.step)
                    data.value.wrappedValue = max(newValue, data.range.lowerBound)
                }label:{
                    Image(systemName: "minus")
                }
                .buttonRepeatBehavior(.enabled)
                .disabled(isDecrementDisabled)
                .opacity(isDecrementDisabled ? 0.5 : 1)
                .foregroundStyle(.primary)
                .buttonBorderShape(.circle)
                .accessibilityLabel("Decrement \(data.title)")
            }
            .scaleEffect(0.70)
        }
        .padding(.leading, 16)
        .padding(.trailing, -7)
        .padding(.vertical, -1)
        .background(LinearGradient(
            colors: [
                .black.opacity(0.4),
                .black.opacity(0.3)
            ],
            startPoint: .top,
            endPoint: .bottom
        ))
        .clipShape(RoundedRectangle(cornerRadius: data.cornerRadius ?? 12, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: data.cornerRadius ?? 12, style: .continuous)
                .stroke(LinearGradient(
                    colors: [
                        .black.opacity(0.4),
                        .white.opacity(0.3)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                ), lineWidth: 1.25)
        )
        .contentShape(Rectangle())
        .hoverEffect()
        .clipShape(RoundedRectangle(cornerRadius: data.cornerRadius ?? 12, style: .continuous))
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
