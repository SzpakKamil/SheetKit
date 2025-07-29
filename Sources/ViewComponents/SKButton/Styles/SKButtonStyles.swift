//
//  SKButtonStyles.swift
//  SheetKit
//
//  Created by Kamil Szpak on 27/07/2025.
//

import SwiftUI

public struct SKPrimaryButtonStyle: ButtonStyle {
    let isEnabled: Bool
    let accentColor: Color
    let colorScheme: ColorScheme
    public func makeBody(configuration: Configuration) -> some View {
        #if os(iOS)
        SKPrimaryButtonStyleIOS(isEnabled: isEnabled, accentColor: accentColor).makeBody(configuration: configuration)
        #elseif os(macOS)
        SKPrimaryButtonStyleMACOS(isEnabled: isEnabled, accentColor: accentColor, colorScheme: colorScheme).makeBody(configuration: configuration)
        #elseif os(tvOS)
        SKPrimaryButtonStyleTVOS(isEnabled: isEnabled, accentColor: accentColor).makeBody(configuration: configuration)
        #elseif os(visionOS)
        SKPrimaryButtonStyleVISIONOS(isEnabled: isEnabled, accentColor: accentColor).makeBody(configuration: configuration)
        #elseif os(watchOS)
        SKPrimaryButtonStyleWATCHOS().makeBody(configuration: configuration)
        #else
        EmptyView()
        #endif
    }
    
    public init(isEnabled: Bool, accentColor: Color, colorScheme: ColorScheme) {
        self.isEnabled = isEnabled
        self.accentColor = accentColor
        self.colorScheme = colorScheme
    }
}
public struct SKSecondaryButtonStyle: ButtonStyle {
    let isEnabled: Bool
    let accentColor: Color
    public func makeBody(configuration: Configuration) -> some View {
        #if os(iOS)
        SKSecondaryButtonStyleIOS(isEnabled: isEnabled, accentColor: accentColor).makeBody(configuration: configuration)
        #elseif os(macOS)
        SKSecondaryButtonStyleMACOS(isEnabled: isEnabled, accentColor: accentColor).makeBody(configuration: configuration)
        #elseif os(tvOS)
        SKSecondaryButtonStyleTVOS(isEnabled: isEnabled, accentColor: accentColor).makeBody(configuration: configuration)
        #elseif os(visionOS)
        SKSecondaryButtonStyleVISIONOS(isEnabled: isEnabled, accentColor: accentColor).makeBody(configuration: configuration)
        #elseif os(watchOS)
        SKSecondaryButtonStyleWATCHOS().makeBody(configuration: configuration)
        #else
        EmptyView()
        #endif
    }
    
    public init(isEnabled: Bool, accentColor: Color) {
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
        #elseif os(watchOS)
        SKNoteButtonStyleWATCHOS(textAlignment: textAlignment).makeBody(configuration: configuration)
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
        #elseif os(watchOS)
        SKNavigationButtonStyleWATCHOS().makeBody(configuration: configuration)
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
struct SKButtonStylesPreviewContent: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var style: String = "Primary"
    var body: some View {
        List{
            Picker("Styles", selection: $style) {
                Text("Primary")
                    .tag("Primary")
                Text("Secondary")
                    .tag("Secondary")
                Text("Note")
                    .tag("Note")
                Text("Navigation")
                    .tag("Navigation")
            }
            
            switch style{
            case "Primary":
                Button("Next"){
                    
                }.buttonStyle(SKPrimaryButtonStyle(isEnabled: true, accentColor: .accentColor, colorScheme: colorScheme))
            case "Secondary":
                Button("Back"){
                    
                }.buttonStyle(SKSecondaryButtonStyle(isEnabled: true, accentColor: .accentColor))
            case "Note":
                Button("Note"){
                    
                }.buttonStyle(SKNoteButtonStyle(isEnabled: true, accentColor: .accentColor, colorScheme: colorScheme))
            default:
                Button{
                    
                }label: {
                    Image(systemName: "chevron.backward")
                }
                .buttonStyle(SKNavigationButtonStyle(colorScheme: colorScheme, sheetSize: .medium, isEnabled: true, accentColor: .accentColor))
            }
        }
    }
    
    init(style: String = "Primary") {
        self.style = style
    }
}
#Preview {
    SKButtonStylesPreviewContent()
}
#endif
