//
//  SKButtonStyles.swift
//  SheetKit
//
//  Created by Kamil Szpak on 27/07/2025.
//

import SwiftUI

public struct SKPrimaryButtonStyle: ButtonStyle {
    let sheetSize: SKSheetSize?
    let isEnabled: Bool
    let accentColor: Color
    let colorScheme: ColorScheme
    public func makeBody(configuration: Configuration) -> some View {
        #if os(iOS)
        SKPrimaryButtonStyleIOS(isEnabled: isEnabled, accentColor: accentColor).makeBody(configuration: configuration)
        #elseif os(macOS)
        SKPrimaryButtonStyleMACOS(isEnabled: isEnabled, accentColor: accentColor, sheetSize: sheetSize, colorScheme: colorScheme).makeBody(configuration: configuration)
        #elseif os(tvOS)
        SKPrimaryButtonStyleTVOS(isEnabled: isEnabled, accentColor: accentColor).makeBody(configuration: configuration)
        #elseif os(visionOS)
        SKPrimaryButtonStyleVISIONOS(isEnabled: isEnabled, accentColor: accentColor).makeBody(configuration: configuration)
        #else
        EmptyView()
        #endif
    }
    
    public init(isEnabled: Bool, accentColor: Color, sheetSize: SKSheetSize?, colorScheme: ColorScheme) {
        self.isEnabled = isEnabled
        self.sheetSize = sheetSize
        self.accentColor = accentColor
        self.colorScheme = colorScheme
    }
}
public struct SKSecondaryButtonStyle: ButtonStyle {
    let sheetSize: SKSheetSize?
    let isEnabled: Bool
    let accentColor: Color
    public func makeBody(configuration: Configuration) -> some View {
        #if os(iOS)
        SKSecondaryButtonStyleIOS(isEnabled: isEnabled, accentColor: accentColor).makeBody(configuration: configuration)
        #elseif os(macOS)
        SKSecondaryButtonStyleMACOS(sheetSize: sheetSize, isEnabled: isEnabled, accentColor: accentColor).makeBody(configuration: configuration)
        #elseif os(tvOS)
        SKSecondaryButtonStyleTVOS(isEnabled: isEnabled, accentColor: accentColor).makeBody(configuration: configuration)
        #elseif os(visionOS)
        SKSecondaryButtonStyleVISIONOS(isEnabled: isEnabled, accentColor: accentColor).makeBody(configuration: configuration)
        #else
        EmptyView()
        #endif
    }
    
    public init(sheetSize: SKSheetSize?, isEnabled: Bool, accentColor: Color) {
        self.sheetSize = sheetSize
        self.isEnabled = isEnabled
        self.accentColor = accentColor
    }
}

public struct SKNoteButtonStyle: ButtonStyle {
    let isEnabled: Bool
    let accentColor: Color
    let colorScheme: ColorScheme
    let textAlignment: TextAlignment
    public func makeBody(configuration: Configuration) -> some View {
        #if os(iOS)
        SKNoteButtonStyleIOS(colorScheme: colorScheme, isEnabled: isEnabled, accentColor: accentColor, textAlignment: textAlignment).makeBody(configuration: configuration)
        #elseif os(macOS)
        SKNoteButtonStyleMACOS(isEnabled: isEnabled, accentColor: accentColor, colorScheme: colorScheme, textAlignment: textAlignment).makeBody(configuration: configuration)
        #elseif os(tvOS)
        SKNoteButtonStyleTVOS(isEnabled: isEnabled, accentColor: accentColor, colorScheme: colorScheme, textAlignment: textAlignment).makeBody(configuration: configuration)
        #elseif os(visionOS)
        SKNoteButtonStyleVISIONOS(colorScheme: colorScheme, isEnabled: isEnabled, accentColor: accentColor, textAlignment: textAlignment).makeBody(configuration: configuration)
        #else
        EmptyView()
        #endif
    }
    public init(isEnabled: Bool, accentColor: Color, colorScheme: ColorScheme, textAlignment: TextAlignment = .leading) {
        self.isEnabled = isEnabled
        self.accentColor = accentColor
        self.colorScheme = colorScheme
        self.textAlignment = textAlignment
    }
}

public struct SKNavigationButtonStyle: ButtonStyle {
    let colorScheme: ColorScheme
    let sheetSize: SKSheetSize?
    let isEnabled: Bool
    let accentColor: Color
    public func makeBody(configuration: Configuration) -> some View {
        #if os(iOS)
        SKNavigationButtonStyleIOS(sheetSize: sheetSize, colorScheme: colorScheme, isEnabled: isEnabled, accentColor: accentColor).makeBody(configuration: configuration)
        #elseif os(macOS)
        SKNavigationButtonStyleMACOS(sheetSize: sheetSize, isEnabled: isEnabled, accentColor: accentColor, colorScheme: colorScheme).makeBody(configuration: configuration)
        #elseif os(tvOS)
        SKNavigationButtonStyleTVOS(sheetSize: sheetSize, isEnabled: isEnabled, accentColor: accentColor).makeBody(configuration: configuration)
        #elseif os(visionOS)
        SKNavigationButtonStyleVISIONOS(sheetSize: sheetSize, colorScheme: colorScheme, isEnabled: isEnabled, accentColor: accentColor).makeBody(configuration: configuration)
        #else
        EmptyView()
        #endif
    }
    
    public init(colorScheme: ColorScheme, sheetSize: SKSheetSize?, isEnabled: Bool, accentColor: Color) {
        self.colorScheme = colorScheme
        self.sheetSize = sheetSize
        self.isEnabled = isEnabled
        self.accentColor = accentColor
    }
}

#if DEBUG
#Preview {
    PreviewViewSKButton()
}
#endif
