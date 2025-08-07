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
                .contentTransition(.numericText())
                .animation(.smooth, value: data.value.wrappedValue)
            Spacer()
            Stepper("", value: data.value, in: data.range, step: data.step)
        }
        .padding(.leading, 16)
        .padding(.trailing, 7)
        .padding(.vertical, 6)
        .background(autoBackgroundColor)
        .if{ content in
            if #available(iOS 26.0, *){
                content
                    .clipShape(RoundedRectangle(cornerRadius: data.cornerRadius ?? 100, style: .continuous))
            }else{
                content
                    .clipShape(RoundedRectangle(cornerRadius: data.cornerRadius ?? 13, style: .continuous))
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
