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
        .background(.tint)
        .clipShape(.capsule)
        .opacity( configuration.isPressed ? 0.5 : 1)
        .opacity(isEnabled ? 1 : 0.5)
        .contentShape(Rectangle())
        .hoverEffect()
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
        .background(.white)
        .clipShape(.capsule)
        .opacity(configuration.isPressed ? 0.5 : 1)
        .opacity(isEnabled ? 1 : 0.5)
        .contentShape(Rectangle())
        .hoverEffect()
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
    }
    
    init(colorScheme: ColorScheme, isEnabled: Bool, accentColor: Color, textAlignment: TextAlignment = .leading) {
        self.colorScheme = colorScheme
        self.isEnabled = isEnabled
        self.accentColor = accentColor
        self.textAlignment = textAlignment
    }
}

struct SKNavigationButtonStyleVISIONOS: ButtonStyle {
    let sheetSize: SKSheetSize?
    let colorScheme: ColorScheme
    let isEnabled: Bool
    let accentColor: Color
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .labelsHidden()
    }
    init(sheetSize: SKSheetSize?, colorScheme: ColorScheme, isEnabled: Bool, accentColor: Color) {
        self.sheetSize = sheetSize
        self.colorScheme = colorScheme
        self.isEnabled = isEnabled
        self.accentColor = accentColor
    }
}

#if DEBUG
#Preview(windowStyle: .automatic){
    SKButtonStylesPreviewContent()
}
#endif

#endif
