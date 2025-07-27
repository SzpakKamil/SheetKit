//
//  SKButtonStyles.swift
//  SheetKit
//
//  Created by Kamil Szpak on 27/07/2025.
//

import SwiftUI

struct SKPrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        #if os(iOS)
        SKPrimaryButtonStyleIOS().makeBody(configuration: configuration)
        #elseif os(macOS)
        SKPrimaryButtonStyleMACOS().makeBody(configuration: configuration)
        #elseif os(tvOS)
        SKPrimaryButtonStyleTVOS().makeBody(configuration: configuration)
        #elseif os(visionOS)
        SKPrimaryButtonStyleVISIONOS().makeBody(configuration: configuration)
        #elseif os(watchOS)
        SKPrimaryButtonStyleWATCHOS().makeBody(configuration: configuration)
        #else
        EmptyView()
        #endif
    }
}
struct SKSecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        #if os(iOS)
        SKSecondaryButtonStyleIOS().makeBody(configuration: configuration)
        #elseif os(macOS)
        SKSecondaryButtonStyleMACOS().makeBody(configuration: configuration)
        #elseif os(tvOS)
        SKSecondaryButtonStyleTVOS().makeBody(configuration: configuration)
        #elseif os(visionOS)
        SKSecondaryButtonStyleVISIONOS().makeBody(configuration: configuration)
        #elseif os(watchOS)
        SKSecondaryButtonStyleWATCHOS().makeBody(configuration: configuration)
        #else
        EmptyView()
        #endif
    }
}

struct SKNoteButtonStyle: ButtonStyle {
    var textAlignment: TextAlignment
    func makeBody(configuration: Configuration) -> some View {
        #if os(iOS)
        SKNoteButtonStyleIOS(textAlignment: textAlignment).makeBody(configuration: configuration)
        #elseif os(macOS)
        SKNoteButtonStyleMACOS(textAlignment: textAlignment).makeBody(configuration: configuration)
        #elseif os(tvOS)
        SKNoteButtonStyleTVOS(textAlignment: textAlignment).makeBody(configuration: configuration)
        #elseif os(visionOS)
        SKNoteButtonStyleVISIONOS(textAlignment: textAlignment).makeBody(configuration: configuration)
        #elseif os(watchOS)
        SKNoteButtonStyleWATCHOS(textAlignment: textAlignment).makeBody(configuration: configuration)
        #else
        EmptyView()
        #endif
    }
    init(textAlignment: TextAlignment = .leading) {
        self.textAlignment = textAlignment
    }
}

struct SKNavigationButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        #if os(iOS)
        SKNavigationButtonStyleIOS().makeBody(configuration: configuration)
        #elseif os(macOS)
        SKNavigationButtonStyleMACOS().makeBody(configuration: configuration)
        #elseif os(tvOS)
        SKNavigationButtonStyleTVOS().makeBody(configuration: configuration)
        #elseif os(visionOS)
        SKNavigationButtonStyleVISIONOS().makeBody(configuration: configuration)
        #elseif os(watchOS)
        SKNavigationButtonStyleWATCHOS().makeBody(configuration: configuration)
        #else
        EmptyView()
        #endif
    }
}

#if DEBUG
struct SKButtonStylesPreviewContent: View {
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
                Button("Primary"){
                    
                }.buttonStyle(SKPrimaryButtonStyle())
            case "Secondary":
                Button("Secondary"){
                    
                }.buttonStyle(SKSecondaryButton())
            case "Note":
                Button("Note"){
                    
                }.buttonStyle(SKNoteButton())
            default:
                Button("Navigation"){
                    
                }.buttonStyle(SKNavigationButton())
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
