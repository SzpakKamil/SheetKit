//
//  SKButton.swift
//  SheetKit
//
//  Created by Kamil Szpak on 29/07/2025.
//

import SwiftUI

public struct SKButton<TextContent: View, ImageContent: View>: View {
    @Environment(\.skToolbarButtonAction) var toolbarButtonAction
    @Environment(\.skToolbarPlacement) var toolbarPlacement
    @Environment(\.isEnabled) var isEnabled
    @Environment(\.skAccentColor) var accentColor
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.skSheetStyle) var sheetStyle
    private let action: () -> Void
    private let text: TextContent
    private let image: ImageContent
    private let destination: URL?

    public var body: some View {
        Group {
            if let destination {
                Link(destination: destination) {
                    Group{
                        #if os(watchOS)
                        if ImageContent.self != EmptyView.self && toolbarPlacement != .note {
                            image
                                .accessibilityHidden(true)
                        } else if toolbarPlacement == .note {
                            Image(systemName: "info")
                        }else{
                            text
                        }
                        #elseif os(macOS)
                        if #available(macOS 26.0, *){
                            if ImageContent.self != EmptyView.self && sheetStyle == .compact && toolbarPlacement == .navigation {
                                image
                                    .accessibilityHidden(true)
                            } else {
                                text
                            }
                        }else{
                            text
                        }
                        #elseif !os(iOS)
                        if ImageContent.self != EmptyView.self && sheetStyle == .compact && toolbarPlacement == .navigation {
                            image
                                .accessibilityHidden(true)
                        } else {
                            text
                        }
                        #else
                        HStack {
                            if ImageContent.self != EmptyView.self && toolbarPlacement == .navigation {
                                if #available(iOS 26.0, *) {
                                    image
                                        .accessibilityHidden(true)
                                } else {
                                    HStack {
                                        image
                                            .accessibilityHidden(true)
                                        text
                                    }
                                }
                            } else {
                                text
                            }
                        }
                        #endif
                    }
                    .lineLimit(1)
                }
            } else {
                Button {
                    action()
                    toolbarButtonAction()
                } label: {
                    Group{
                        #if os(watchOS)
                        if ImageContent.self != EmptyView.self && toolbarPlacement != .note {
                            image
                                .accessibilityHidden(true)
                        } else if toolbarPlacement == .note {
                            Image(systemName: "info")
                        }else{
                            text
                        }
                        #elseif os(macOS)
                        if #available(macOS 26.0, *){
                            if ImageContent.self != EmptyView.self && sheetStyle == .compact && toolbarPlacement == .navigation {
                                image
                                    .accessibilityHidden(true)
                            } else {
                                text
                            }
                        }else{
                            text
                        }
                        #elseif !os(iOS)
                        if ImageContent.self != EmptyView.self && sheetStyle == .compact && toolbarPlacement == .navigation {
                            image
                                .accessibilityHidden(true)
                        } else {
                            text
                        }
                        #else
                        HStack {
                            if ImageContent.self != EmptyView.self && toolbarPlacement == .navigation {
                                if #available(iOS 26.0, *) {
                                    image
                                        .accessibilityHidden(true)
                                } else {
                                    HStack {
                                        image
                                            .accessibilityHidden(true)
                                        text
                                    }
                                }
                            } else {
                                text
                            }
                        }
                        #endif
                    }
                    .lineLimit(1)
                }
            }
        }
        .if { content in
            #if os(watchOS)
            content
            #else
            switch toolbarPlacement {
            case .primary: content.buttonStyle(SKPrimaryButtonStyle(isEnabled: isEnabled, accentColor: accentColor, sheetStyle: sheetStyle, colorScheme: colorScheme))
            case .secondary: content.buttonStyle(SKSecondaryButtonStyle(sheetStyle: sheetStyle, isEnabled: isEnabled, accentColor: accentColor))
            case .navigation: content.buttonStyle(SKNavigationButtonStyle(colorScheme: colorScheme, sheetStyle: sheetStyle, isEnabled: isEnabled, accentColor: accentColor))
            case .note: content.buttonStyle(SKNoteButtonStyle(isEnabled: isEnabled, accentColor: accentColor, colorScheme: colorScheme))
            default: content.buttonStyle(SKPrimaryButtonStyle(isEnabled: isEnabled, accentColor: accentColor, sheetStyle: sheetStyle, colorScheme: colorScheme))
            }
            #endif
        }
    }

    public init(text: () -> TextContent, image: () -> ImageContent, action: @escaping @MainActor () -> Void) {
        self.text = text()
        self.image = image()
        self.action = action
        self.destination = nil
    }

    public init(text: () -> TextContent, image: () -> ImageContent, destination: URL) {
        self.text = text()
        self.image = image()
        self.action = {}
        self.destination = destination
    }

    public init(text: () -> TextContent, action: @escaping @MainActor () -> Void) where ImageContent == EmptyView {
        self.text = text()
        self.image = EmptyView()
        self.action = action
        self.destination = nil
    }

    public init(text: () -> TextContent, destination: URL) where ImageContent == EmptyView {
        self.text = text()
        self.image = EmptyView()
        self.action = {}
        self.destination = destination
    }

    public init(image: () -> ImageContent, action: @escaping @MainActor () -> Void) where TextContent == EmptyView {
        self.text = EmptyView()
        self.image = image()
        self.action = action
        self.destination = nil
    }

    public init(image: () -> ImageContent, destination: URL) where TextContent == EmptyView {
        self.text = EmptyView()
        self.image = image()
        self.action = {}
        self.destination = destination
    }
}

extension SKButton {
    public init(_ title: String, action: @escaping @MainActor () -> Void) where TextContent == Text, ImageContent == EmptyView {
        self.init(text: { Text(verbatim: title) }, action: action)
    }
    public init(_ title: String, systemImage: String, action: @escaping @MainActor () -> Void)  where TextContent == Text, ImageContent == Image {
        self.init(text: { Text(verbatim: title) }, image: { Image(systemName: systemImage) }, action: action)
    }
    public init(_ title: String, image: Image, action: @escaping @MainActor () -> Void) where TextContent == Text, ImageContent == Image {
        self.init(text: { Text(verbatim: title) }, image: { image }, action: action)
    }
    public init(_ titleKey: LocalizedStringKey, action: @escaping @MainActor () -> Void)where TextContent == Text, ImageContent == EmptyView {
        self.init(text: { Text(titleKey) }, action: action)
    }
    public init(_ titleKey: LocalizedStringKey, systemImage: String, action: @escaping @MainActor () -> Void) where TextContent == Text, ImageContent == Image{
        self.init(text: { Text(titleKey) }, image: { Image(systemName: systemImage) }, action: action)
    }
    public init(_ titleKey: LocalizedStringKey, image: Image, action: @escaping @MainActor () -> Void) where TextContent == Text, ImageContent == Image {
        self.init(text: { Text(titleKey) }, image: { image }, action: action)
    }
    public init(systemImage: String, action: @escaping @MainActor () -> Void) where TextContent == EmptyView, ImageContent == Image {
        self.init(image: { Image(systemName: systemImage) }, action: action)
    }
    public init(image: Image, action: @escaping @MainActor () -> Void) where TextContent == EmptyView, ImageContent == Image {
        self.init(image: { image }, action: action)
    }

    public init(_ title: String, destination: URL) where TextContent == Text, ImageContent == EmptyView {
        self.init(text: { Text(verbatim: title) }, destination: destination)
    }
    public init(_ title: String, systemImage: String, destination: URL) where TextContent == Text, ImageContent == Image {
        self.init(text: { Text(verbatim: title) }, image: { Image(systemName: systemImage) }, destination: destination)
    }
    public init(_ title: String, image: Image, destination: URL) where TextContent == Text, ImageContent == Image {
        self.init(text: { Text(verbatim: title) }, image: { image }, destination: destination)
    }
    public init(_ titleKey: LocalizedStringKey, destination: URL) where TextContent == Text, ImageContent == EmptyView {
        self.init(text: { Text(titleKey) }, destination: destination)
    }
    public init(_ titleKey: LocalizedStringKey, systemImage: String, destination: URL) where TextContent == Text, ImageContent == Image {
        self.init(text: { Text(titleKey) }, image: { Image(systemName: systemImage) }, destination: destination)
    }
    public init(_ titleKey: LocalizedStringKey, image: Image, destination: URL) where TextContent == Text, ImageContent == Image {
        self.init(text: { Text(titleKey) }, image: { image }, destination: destination)
    }
    public init(systemImage: String, destination: URL) where TextContent == EmptyView, ImageContent == Image {
        self.init(image: { Image(systemName: systemImage) }, destination: destination)
    }
    public init(image: Image, destination: URL) where TextContent == EmptyView, ImageContent == Image {
        self.init(image: { image }, destination: destination)
    }
}

#if DEBUG
struct PreviewViewSKButton: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.skSheetStyle) var sheetStyle
    @State private var style: String = "Primary"
    var body: some View {
        List {
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

            switch style {
            case "Primary":
                Button("Next") {

                }.buttonStyle(SKPrimaryButtonStyle(isEnabled: true, accentColor: .accentColor, sheetStyle: sheetStyle, colorScheme: colorScheme))
            case "Secondary":
                Button("Back") {

                }.buttonStyle(SKSecondaryButtonStyle(sheetStyle: sheetStyle, isEnabled: true, accentColor: .accentColor))
            case "Note":
                Button("Note") {

                }.buttonStyle(SKNoteButtonStyle(isEnabled: true, accentColor: .accentColor, colorScheme: colorScheme))
            default:
                Button {
                } label: {
                    Image(systemName: "chevron.backward")
                }
                .buttonStyle(SKNavigationButtonStyle(colorScheme: colorScheme, sheetStyle: .compact, isEnabled: true, accentColor: .accentColor))
            }
        }
    }

    init(style: String = "Primary") {
        self.style = style
    }
}
#Preview {
    PreviewViewSKButton()
}
#endif

