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
    public let type: SKComponentType = .field
    var data: SKStepper<S>.Data
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
    public var body: some View {
        HStack(spacing: 0){
            Text("\(data.title): \(data.textForValue(data.value.wrappedValue))")
                .contentTransition(.numericText())
                .animation(.smooth, value: data.value.wrappedValue)
            Spacer()
            if let range = data.range{
                Stepper("", value: data.value, in: range, step: data.step)
            }else{
                Stepper("", value: data.value, step: data.step)
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
