//
//  SKButtonStyles.swift
//  SheetKit
//
//  Created by Kamil Szpak on 27/07/2025.
//

import SwiftUI

public struct SKPrimaryButtonStyle: ButtonStyle {
    let sheetStyle: SKSheetStyle?
    let isEnabled: Bool
    let accentColor: Color
    let colorScheme: ColorScheme
    
    @_documentation(visibility: internal)
    public func makeBody(configuration: Configuration) -> some View {
        #if os(iOS)
        SKPrimaryButtonStyleIOS(isEnabled: isEnabled, accentColor: accentColor).makeBody(configuration: configuration)
        #elseif os(macOS)
        SKPrimaryButtonStyleMACOS(isEnabled: isEnabled, accentColor: accentColor, sheetStyle: sheetStyle, colorScheme: colorScheme).makeBody(configuration: configuration)
        #elseif os(tvOS)
        SKPrimaryButtonStyleTVOS(isEnabled: isEnabled, accentColor: accentColor, colorSheme: colorScheme).makeBody(configuration: configuration)
        #elseif os(visionOS)
        SKPrimaryButtonStyleVISIONOS(isEnabled: isEnabled, accentColor: accentColor).makeBody(configuration: configuration)
        #else
        EmptyView()
        #endif
    }
    
    public init(isEnabled: Bool, accentColor: Color, sheetStyle: SKSheetStyle?, colorScheme: ColorScheme) {
        self.isEnabled = isEnabled
        self.sheetStyle = sheetStyle
        self.accentColor = accentColor
        self.colorScheme = colorScheme
    }
}
public struct SKSecondaryButtonStyle: ButtonStyle {
    let sheetStyle: SKSheetStyle?
    let isEnabled: Bool
    let accentColor: Color
    
    @_documentation(visibility: internal)
    public func makeBody(configuration: Configuration) -> some View {
        #if os(iOS)
        SKSecondaryButtonStyleIOS(isEnabled: isEnabled, accentColor: accentColor).makeBody(configuration: configuration)
        #elseif os(macOS)
        SKSecondaryButtonStyleMACOS(sheetStyle: sheetStyle, isEnabled: isEnabled, accentColor: accentColor).makeBody(configuration: configuration)
        #elseif os(tvOS)
        SKSecondaryButtonStyleTVOS(isEnabled: isEnabled, accentColor: accentColor).makeBody(configuration: configuration)
        #elseif os(visionOS)
        SKSecondaryButtonStyleVISIONOS(isEnabled: isEnabled, accentColor: accentColor).makeBody(configuration: configuration)
        #else
        EmptyView()
        #endif
    }
    
    public init(sheetStyle: SKSheetStyle?, isEnabled: Bool, accentColor: Color) {
        self.sheetStyle = sheetStyle
        self.isEnabled = isEnabled
        self.accentColor = accentColor
    }
}

public struct SKNoteButtonStyle: ButtonStyle {
    let isEnabled: Bool
    let accentColor: Color
    let colorScheme: ColorScheme
    let textAlignment: TextAlignment
    
    @_documentation(visibility: internal)
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
    let sheetStyle: SKSheetStyle?
    let isEnabled: Bool
    let accentColor: Color
    
    @_documentation(visibility: internal)
    public func makeBody(configuration: Configuration) -> some View {
        #if os(iOS)
        SKNavigationButtonStyleIOS(sheetStyle: sheetStyle, colorScheme: colorScheme, isEnabled: isEnabled, accentColor: accentColor).makeBody(configuration: configuration)
        #elseif os(macOS)
        SKNavigationButtonStyleMACOS(sheetStyle: sheetStyle, isEnabled: isEnabled, accentColor: accentColor, colorScheme: colorScheme).makeBody(configuration: configuration)
        #elseif os(tvOS)
        SKNavigationButtonStyleTVOS(sheetStyle: sheetStyle, isEnabled: isEnabled, accentColor: accentColor).makeBody(configuration: configuration)
        #elseif os(visionOS)
        SKNavigationButtonStyleVISIONOS(sheetStyle: sheetStyle, colorScheme: colorScheme, isEnabled: isEnabled, accentColor: accentColor).makeBody(configuration: configuration)
        #else
        EmptyView()
        #endif
    }
    
    public init(colorScheme: ColorScheme, sheetStyle: SKSheetStyle?, isEnabled: Bool, accentColor: Color) {
        self.colorScheme = colorScheme
        self.sheetStyle = sheetStyle
        self.isEnabled = isEnabled
        self.accentColor = accentColor
    }
}
