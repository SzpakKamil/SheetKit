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
    var data: SKStepper<S>.Data
    var autoBackgroundColor: Color{
        if let backgroundColor = data.backgroundColor{
            return backgroundColor
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
            Text("\(data.title): \(data.textForValue(data.value.wrappedValue))")
                .if{ content in
                    if #unavailable(tvOS 26.0){
                        content
                            .font(.headline)
                    }else{
                        content
                    }
                }
                .contentTransition(.numericText())
                .animation(.smooth, value: data.value.wrappedValue)
            Spacer()
            HStack(spacing: 8){
                let isIncrementDisabled = data.value.wrappedValue >= data.range.upperBound
                let isDecrementDisabled = data.value.wrappedValue <= data.range.lowerBound
                Button{
                    let newValue = data.value.wrappedValue.advanced(by: data.step)
                    data.value.wrappedValue = min(newValue, data.range.upperBound)
                }label:{
                    Label("Increment", systemImage: "plus")
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
                    Label("Decrement", systemImage: "minus")
                        .if{ content in
                            if #unavailable(tvOS 26.0){
                                content
                                    .padding(.all, 13)
                            }else{
                                content
                            }
                        }
                }
                .buttonRepeatBehavior(.enabled)
                .disabled(isDecrementDisabled)
                .opacity(isDecrementDisabled ? 0.5 : 1)
                .foregroundStyle(.primary)
                .buttonBorderShape(.circle)
                .accessibilityLabel("Decrement \(data.title)")
            }
            .scaleEffect(0.9)
        }

        .padding(.trailing, 4)
        .if{ content in
            if #available(tvOS 26.0, *){
                content
                    .padding(.leading, 22)
                    .background(autoBackgroundColor, in: RoundedRectangle(cornerRadius: data.cornerRadius ?? 50, style: .continuous))
            }else{
                content
                    .padding(.vertical, 13)
                    .padding(.leading, 32)
                    .background(autoBackgroundColor, in: RoundedRectangle(cornerRadius: data.cornerRadius ?? 10, style: .continuous))
            }
            
        }
       

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
