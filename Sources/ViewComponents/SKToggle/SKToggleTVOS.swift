//
//  SKToggleTVOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 11/09/2025.
//

import SwiftUI

#if os(tvOS)
struct SKToggleTVOS: View {
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
            if #available(tvOS 26.0, *){
                return colorScheme == .dark ? .black.opacity(0.5) : .white.opacity(0.5)
            }else if #available(tvOS 18.0, *){
                return colorScheme == .dark ? .white.opacity(0.1) : .black.opacity(0.1)
            }else{
                return colorScheme == .dark ? .white : .black
            }
        }
    }
    
    var textColor: Color{
        return colorScheme == .dark ? .white : .black
    }
    
    
    var body: some View {
        Toggle(isOn: $isOn) {
            Group{
                Text(data.title)
                    .foregroundStyle(textColor)
            }
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(skIsInSection ? .roundedRectangle(radius: 0) : skRowShape == nil ? .automatic : .roundedRectangle(radius: skRowShape!))
        .tint(autoBackgroundColor)
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
