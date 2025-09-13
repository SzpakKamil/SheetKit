//
//  SKToggleWATCHOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 11/09/2025.
//

import SwiftUI

#if os(watchOS)
struct SKToggleWATCHOS: View {
    @Environment(\.skRowShape) var skRowShape
    @Environment(\.skRowBackgroundColor) var skRowBackgroundColor
    @Environment(\.colorScheme) var colorScheme
    @Binding var isOn: Bool
    var data: SKToggle.Data
    
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
        Toggle(isOn: $isOn) {
            Text(data.title)
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 13)
        .background(autoBackgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: skRowShape ?? 100, style: .continuous))
        .buttonStyle(.plain)
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
