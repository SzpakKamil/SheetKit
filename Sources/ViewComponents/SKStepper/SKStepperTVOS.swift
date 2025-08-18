//
//  SKStepperTVOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 01/08/2025.
//

import SwiftUI

#if os(tvOS)
struct SKStepperTVOS<S: Strideable>: View, SKComponent {

    @Environment(\.colorScheme) var colorScheme
    public let type: SKComponentType = .field
    @Environment(\.skRowShape) var skRowShape
    @Environment(\.skRowBackgroundColor) var skRowBackgroundColor
    @Binding var value: S
    var data: SKStepper<S>.Data
    var autoBackgroundColor: Color{
        if let skRowBackgroundColor{
            return skRowBackgroundColor
        }else{
            if #available(tvOS 26.0, *){
                return colorScheme == .dark ? .black.opacity(0.5) : .white.opacity(0.5)
            }else if #available(tvOS 18.0, *){
                return colorScheme == .dark ? .white.opacity(0.1) : .black.opacity(0.1)
            }else{
                return colorScheme == .dark ? .white : .black
            }
        }
    }
    public var body: some View {
        HStack(spacing: 0){
            Text("\(data.title): \(data.textForValue(value))")
                .if{ content in
                    if #unavailable(tvOS 26.0){
                        content
                            .font(.headline)
                    }else{
                        content
                    }
                }
                .contentTransition(.numericText())
                .animation(.smooth, value: value)
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
                        .frame(width: 20, height: 20)
                }
                .buttonRepeatBehavior(.enabled)
                .disabled(isIncrementDisabled)
                .opacity(isIncrementDisabled ? 0.5 : 1)
                .foregroundStyle(.primary)
                .if{ content in
                    if #available(tvOS 26.0, *){
                        content
                            .buttonBorderShape(.roundedRectangle(radius: skRowShape ?? 50))
                    }else{
                        content
                            .buttonBorderShape(.roundedRectangle(radius: skRowShape ?? 12))
                    }
                }
                .accessibilityLabel("Increment \(data.title)")
                
                Button{
                    let newValue = value.advanced(by: -data.step)
                    if let range = data.range{
                        value = max(newValue, range.lowerBound)
                    }else{
                        value = newValue
                    }

                }label:{
                    Image(systemName: "minus")
                        .frame(width: 20, height: 20)
                }
                .buttonRepeatBehavior(.enabled)
                .disabled(isDecrementDisabled)
                .opacity(isDecrementDisabled ? 0.5 : 1)
                .foregroundStyle(.primary)
                .padding(.trailing, 4)
                .if{ content in
                    if #available(tvOS 26.0, *){
                        content
                            .buttonBorderShape(.roundedRectangle(radius: skRowShape ?? 50))
                    }else{
                        content
                            .buttonBorderShape(.roundedRectangle(radius: skRowShape ?? 12))
                    }
                }
                .accessibilityLabel("Decrement \(data.title)")
            }
            .scaleEffect(0.9)
        }

        .padding(.trailing, 4)
        .if{ content in
            if #available(tvOS 26.0, *){
                content
                    .padding(.leading, 22)
                    .background(autoBackgroundColor, in: RoundedRectangle(cornerRadius: skRowShape ?? 50, style: .continuous))
            }else{
                content
                    .padding(.vertical, 22)
                    .padding(.leading, 32)
                    .padding(.trailing, -10)
                    .background(autoBackgroundColor, in: RoundedRectangle(cornerRadius: skRowShape ?? 10, style: .continuous))
            }
        }
    }
    
    public init(value: Binding<S>, data: SKStepper<S>.Data) {
        self._value = value
        self.data = data
    }
}

#if DEBUG
#Preview {
    PreviewViewSKStepper()
}
#endif
#endif
