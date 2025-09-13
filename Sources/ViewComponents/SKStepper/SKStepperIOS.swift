//
//  SKStepperIOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 01/08/2025.
//

import SwiftUI

#if os(iOS)
struct SKStepperIOS<S: Strideable>: View, SKComponent {

    @Environment(\.colorScheme) var colorScheme
    @Environment(\.skRowShape) var skRowShape
    @Environment(\.skRowBackgroundColor) var skRowBackgroundColor
    let type: SKComponentType = .field
    var data: SKStepper<S>.Data
    @Binding var value: S
    var autoBackgroundColor: Color{
        if let skRowBackgroundColor{
            return skRowBackgroundColor
        }else{
            if colorScheme == .dark{
                return Color(red: 0.1647058824, green: 0.1647058824, blue: 0.1764705882)
            }else{
                return .white
            }
        }
    }
    var body: some View {
        HStack(spacing: 0){
            Text("\(data.title): \(data.textForValue(value))")
                .contentTransition(.numericText())
                .animation(.smooth, value: value)
            Spacer()
            if let range = data.range{
                Stepper(value: $value, in: range, step: data.step){
                    Text(verbatim: "")
                }
            }else{
                Stepper(value: $value, step: data.step){
                    Text(verbatim: "")
                }
            }
        }
        .padding(.leading, 16)
        .padding(.trailing, 7)
        .padding(.vertical, 7.25)
        .background(autoBackgroundColor)
        .if{ content in
            if #available(iOS 26.0, *){
                content
                    .clipShape(RoundedRectangle(cornerRadius: skRowShape ?? 100, style: .continuous))
            }else{
                content
                    .clipShape(RoundedRectangle(cornerRadius: skRowShape ?? 13, style: .continuous))
            }
        }
        .accessibilityElement()
        .accessibilityLabel(data.title)
        .accessibilityValue(data.textForValue(value))
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment:
                if let range = data.range, value.distance(to: range.upperBound) != 0{
                    value = value.advanced(by: 1)
                }
            case .decrement:
                if let range = data.range, value.distance(to: range.lowerBound) != 0{
                    value = value.advanced(by: -1)
                }
            default:
                print("Not handled.")
            }
        }
        .accessibilityAddTraits(.isButton)
        .contentShape(Rectangle())
    }
    
    init(value: Binding<S>, data: SKStepper<S>.Data) {
        self._value = value
        self.data = data
    }
}

#endif
