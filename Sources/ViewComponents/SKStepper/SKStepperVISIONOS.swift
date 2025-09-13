//
//  SKStepperVISIONOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 01/08/2025.
//

import SwiftUI

#if os(visionOS)
struct SKStepperVISIONOS<S: Strideable>: View, SKComponent {
    @Environment(\.skRowShape) var skRowShape
    @Environment(\.skRowBackgroundColor) var skRowBackgroundColor
    @Environment(\.colorScheme) var colorScheme
    let type: SKComponentType = .field
    @Binding var value: S
    var data: SKStepper<S>.Data
    
    var autoBackgroundColor: Color{
        if let skRowBackgroundColor{
            return skRowBackgroundColor
        }else{
            return .black.opacity(0.4)
        }
    }
    
    var body: some View {
        HStack(spacing: 0){
            Text("\(data.title): \(data.textForValue(value))")
            Spacer()
            HStack(spacing: 8){
                let isIncrementDisabled = data.range == nil ? false : value >= data.range!.upperBound
                let isDecrementDisabled = data.range == nil ? false : value <= data.range!.lowerBound
                Button{
                    let newValue = value.advanced(by: data.step)
                    if let range = data.range{
                        value = min(newValue,range.upperBound)
                    }else{
                        value = newValue
                    }
                }label:{
                    Image(systemName: "plus")
                }
                .buttonRepeatBehavior(.enabled)
                .disabled(isIncrementDisabled)
                .opacity(isIncrementDisabled ? 0.5 : 1)
                .foregroundStyle(.primary)
                .buttonBorderShape(.circle)
                .accessibilityElement(children: .combine)
                .accessibilityLabel(SKTranslation.SKStepper.increment.value)
                .accessibilityValue(data.textForValue(value))
                .accessibilityAddTraits(.isButton)
                
                Button{
                    let newValue = value.advanced(by: -data.step)
                    if let range = data.range{
                        value = max(newValue, range.lowerBound)
                    }else{
                        value = newValue
                    }
                }label:{
                    Image(systemName: "minus")
                }
                .buttonRepeatBehavior(.enabled)
                .disabled(isDecrementDisabled)
                .opacity(isDecrementDisabled ? 0.5 : 1)
                .foregroundStyle(.primary)
                .buttonBorderShape(.circle)
                .accessibilityElement(children: .combine)
                .accessibilityLabel(SKTranslation.SKStepper.decrement.value)
                .accessibilityValue(data.textForValue(value))
                .accessibilityAddTraits(.isButton)
            }
            .scaleEffect(0.70)
        }
        .padding(.leading, 16)
        .padding(.trailing, -7)
        .padding(.vertical, -1)
        .background(LinearGradient(
            colors: [
                autoBackgroundColor,
                autoBackgroundColor.opacity(0.75)
            ],
            startPoint: .top,
            endPoint: .bottom
        ))
        .clipShape(RoundedRectangle(cornerRadius: skRowShape ?? 12, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: skRowShape ?? 12, style: .continuous)
                .stroke(LinearGradient(
                    colors: [
                        autoBackgroundColor,
                        .white.opacity(0.3)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                ), lineWidth: 1.25)
        )
        .contentShape(Rectangle())
        .hoverEffect()
        .clipShape(RoundedRectangle(cornerRadius: skRowShape ?? 12, style: .continuous))
    }
    
    init(value: Binding<S>, data: SKStepper<S>.Data) {
        self._value = value
        self.data = data
    }
}
#endif
