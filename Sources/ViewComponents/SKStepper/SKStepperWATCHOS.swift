//
//  SKStepperWATCHOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 01/08/2025.
//

import SwiftUI
#if os(watchOS)
struct SKStepperWATCHOS<S: Strideable>: View, SKComponent {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.skRowBackgroundColor) var skRowBackgroundColor
    @Environment(\.skRowShape) var skRowShape
    @Binding var value: S
    var data: SKStepper<S>.Data
    var type: SKComponentType = .field
    @State private var isUsingStepper: Bool = false
    @State private var tempValue: S
    
    var autoBackgroundColor: Color{
        if let skRowBackgroundColor{
            return skRowBackgroundColor
        }else{
            return .primary.opacity(0.1)
        }
    }
    
    var body: some View {
        Button {
            isUsingStepper = true
            tempValue = value
        }label:{
            VStack{
                Text(data.title)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(data.textForValue(value))
                    .lineLimit(1)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 17)
            .padding(.vertical, 5)
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
            .background(autoBackgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: skRowShape ?? 100, style: .continuous))
        }
        .buttonStyle(.plain)
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
        .fullScreenCover(isPresented: $isUsingStepper) {
            NavigationStack{
                VStack{
                    if let range = data.range{
                        Stepper(data.textForValue(value), value: $value, in: range)
                    }else{
                        Stepper(data.textForValue(value), value: $value)
                    }
                    
                    HStack{
                        Button(SKTranslation.SKStepper.submit.value, role: .cancel) {
                            isUsingStepper = false
                            value = tempValue
                        }
                        Button(SKTranslation.SKStepper.reset.value, role: .destructive) {
                            tempValue = value
                        }
                    }
                }
                .navigationTitle(SKTranslation.SKStepper.title.value)
            }
        }
        
    }
    
    init(value: Binding<S>, data: SKStepper<S>.Data) {
        self.data = data
        self._value = value
        self.tempValue = value.wrappedValue
    }
}
#endif
