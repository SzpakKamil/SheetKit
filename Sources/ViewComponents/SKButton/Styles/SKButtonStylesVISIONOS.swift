//
//  SKButtonStylesVISIONOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 26/07/2025.
//

import SwiftUI

#if os(visionOS)
struct SKPrimaryButtonStyleVISIONOS: ButtonStyle {
    let isEnabled: Bool
    let accentColor: Color
    func makeBody(configuration: Configuration) -> some View {
        HStack{
            Spacer()
            configuration.label
                .buttonStyle(.plain)
            Spacer()
        }
        .foregroundStyle(.white)
        .fontWeight(.medium)
        .padding(.vertical, 17)
        .background(accentColor)
        .clipShape(.capsule)
        .opacity( configuration.isPressed ? 0.5 : 1)
        .opacity(isEnabled ? 1 : 0.5)
        .contentShape(Rectangle())
        .hoverEffect()
        .clipShape(.capsule)
        .scaleEffect(configuration.isPressed ? 0.95 : 1)
        .animation(.smooth(duration: 0.4), value: configuration.isPressed)
    }
    init(isEnabled: Bool, accentColor: Color) {
        self.isEnabled = isEnabled
        self.accentColor = accentColor
    }
}

struct SKSecondaryButtonStyleVISIONOS: ButtonStyle {
    let isEnabled: Bool
    let accentColor: Color
    func makeBody(configuration: Configuration) -> some View {
        HStack{
            Spacer()
            configuration.label
                .buttonStyle(.plain)
            Spacer()
        }
        .foregroundStyle(accentColor)
        .fontWeight(.medium)
        .padding(.vertical, 17)
        .background(.white.opacity(0.10))
        .clipShape(.capsule)
        .opacity(configuration.isPressed ? 0.5 : 1)
        .opacity(isEnabled ? 1 : 0.5)
        .contentShape(Rectangle())
        .hoverEffect()
        .clipShape(.capsule)
        .scaleEffect(configuration.isPressed ? 0.95 : 1)
        .animation(.smooth(duration: 0.4), value: configuration.isPressed)
    }
    init(isEnabled: Bool, accentColor: Color) {
        self.isEnabled = isEnabled
        self.accentColor = accentColor
    }
}

struct SKNoteButtonStyleVISIONOS: ButtonStyle {
    let colorScheme: ColorScheme
    let isEnabled: Bool
    let accentColor: Color
    var textAlignment: TextAlignment
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 3.5){
            if #available(visionOS 26.0, *){
                Image(systemName: "info.circle.fill")
            }
            configuration.label
                .buttonStyle(.plain)
                .multilineTextAlignment(textAlignment)
        }
        .foregroundStyle(accentColor)
        .lineLimit(1)
        .opacity(configuration.isPressed ? 0.5 : 1)
        .contentShape(Rectangle())
        .opacity(isEnabled ? 1 : 0.5)
        .hoverEffect(.lift)
        .scaleEffect(configuration.isPressed ? 0.95 : 1)
        .animation(.smooth(duration: 0.4), value: configuration.isPressed)
    }
    
    init(colorScheme: ColorScheme, isEnabled: Bool, accentColor: Color, textAlignment: TextAlignment = .leading) {
        self.colorScheme = colorScheme
        self.isEnabled = isEnabled
        self.accentColor = accentColor
        self.textAlignment = textAlignment
    }
}

struct SKNavigationButtonStyleVISIONOS: ButtonStyle {
    let sheetStyle: SKSheetStyle?
    let colorScheme: ColorScheme
    let isEnabled: Bool
    let accentColor: Color
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title3)
            .labelsHidden()
            .foregroundStyle(accentColor)
            .fontWeight(.medium)
            .padding(12)
            .background(.white.opacity(0.10))
            .clipShape(.circle)
            .opacity(configuration.isPressed ? 0.5 : 1)
            .opacity(isEnabled ? 1 : 0.5)
            .contentShape(Rectangle())
            .hoverEffect()
            .clipShape(.circle)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.smooth(duration: 0.4), value: configuration.isPressed)
    }
    init(sheetStyle: SKSheetStyle?, colorScheme: ColorScheme, isEnabled: Bool, accentColor: Color) {
        self.sheetStyle = sheetStyle
        self.colorScheme = colorScheme
        self.isEnabled = isEnabled
        self.accentColor = accentColor
    }
}

#if DEBUG
#Preview(windowStyle: .automatic){
    PreviewViewSKButton()
}
#endif

#endif
