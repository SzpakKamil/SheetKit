//
//  SKToggleVISIONOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 11/09/2025.
//

import SwiftUI

#if os(visionOS)
struct SKToggleVISIONOS: View {
    @Environment(\.skRowShape) var skRowShape
    @Environment(\.skRowBackgroundColor) var skRowBackgroundColor
    @Environment(\.colorScheme) var colorScheme
    @Binding var isOn: Bool
    var data: SKToggle.Data
    
    var autoBackgroundColor: Color{
        if let skRowBackgroundColor{
            return skRowBackgroundColor
        }else{
            return .black.opacity(0.4)
        }
    }

    var body: some View {
        HStack{
            Text(data.title)
            Spacer()
            Toggle(isOn: $isOn) {}
                .toggleStyle(.switch)
                .scaleEffect(0.75)
        }
        .padding(.leading)
        .padding(.trailing, -50)
        .padding(.vertical, 5)
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
        .accessibilityElement()
        .accessibilityLabel(data.title)
        .accessibilityValue(Text(isOn ? SKTranslation.SKToggle.on.value : SKTranslation.SKToggle.off.value))
        .accessibilityAction {
            isOn.toggle()
        }
        .accessibilityAddTraits(.isToggle)
    }
}
#endif
