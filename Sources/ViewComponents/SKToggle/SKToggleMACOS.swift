//
//  SKToggleMACOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 11/09/2025.
//

import SwiftUI

#if os(macOS)
struct SKToggleMACOS: View {
    @Environment(\.skRowShape) var skRowShape
    @Environment(\.skRowBackgroundColor) var skRowBackgroundColor
    @Environment(\.skIsInSection) var skIsInSection
    @Environment(\.colorScheme) var colorScheme
    @Binding var isOn: Bool
    var data: SKToggle.Data
    
    var autoBackgroundColor: Color{
        if let skRowBackgroundColor{
            return skRowBackgroundColor
        }else{
            return .clear
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
        .padding(.trailing, -3)
        .padding(.leading, 6.5)
        .background(autoBackgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: skIsInSection ? 0 : skRowShape ?? 6, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: skRowShape ?? 6, style: .continuous)
                .stroke(.primary.opacity(0.06), lineWidth: skIsInSection ? 0 : 1)
        )
        .contentShape(Rectangle())
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
