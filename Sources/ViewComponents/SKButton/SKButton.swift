//
//  SKButton.swift
//  SheetKit
//
//  Created by Kamil Szpak on 29/07/2025.
//

import SwiftUI

public struct SKButton<TextContent: View, ImageContent: View>: View, SKComponent {
    @Environment(\.skToolbarButtonAction) var toolbarButtonAction
    @Environment(\.skToolbarPlacement) var toolbarPlacement
    @Environment(\.isEnabled) var isEnabled
    @Environment(\.skAccentColor) var accentColor
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.skSheetStyle) var sheetStyle
    public let type: SKComponentType = .customView
    private let action: () -> Void
    private let text: TextContent
    private let accessibilityLabel: Text
    private let image: ImageContent
    private let destination: URL?
    
    public var body: some View {
        Group {
            if let destination {
                Link(destination: destination) {
                    Group{
                        #if os(watchOS)
                        HStack {
                            switch (ImageContent.self != EmptyView.self, TextContent.self != EmptyView.self){
                            case (true, true):
                                image
                            case (true, false):
                                image
                            default:
                                text
                            }
                        }
                        #elseif os(macOS)
                        HStack {
                            switch (ImageContent.self != EmptyView.self, TextContent.self != EmptyView.self){
                            case (true, true):
                                if #available(macOS 26.0, *){
                                    if sheetStyle != .default && toolbarPlacement == .navigation {
                                        image
                                            .accessibilityHidden(true)
                                    } else {
                                        text
                                    }
                                }else{
                                    text
                                }
                            case (true, false):
                                image
                            default:
                                text
                            }
                        }
                        #elseif os(tvOS)
                        HStack {
                            switch (ImageContent.self != EmptyView.self, TextContent.self != EmptyView.self){
                            case (true, false):
                                image
                            default:
                                text
                            }
                        }
                        #elseif os(visionOS)
                        HStack {
                            switch (ImageContent.self != EmptyView.self, TextContent.self != EmptyView.self){
                            case (true, true):
                                if toolbarPlacement == .navigation{
                                    image
                                }else{
                                    text
                                }
                            case (true, false):
                                image
                            default:
                                text
                            }
                        }
                        #else
                        HStack {
                            switch (ImageContent.self != EmptyView.self, TextContent.self != EmptyView.self){
                            case (true, true):
                                if toolbarPlacement == .navigation{
                                    if #available(iOS 26.0, *) {
                                        ZStack{
                                            text
                                                .opacity(0)
                                                .frame(width: 0, height: 0)
                                            image
                                                .accessibilityHidden(true)
                                        }
                                    } else {
                                        HStack {
                                            image
                                                .accessibilityHidden(true)
                                            text
                                        }
                                    }
                                }else{
                                    text
                                }
                            case (true, false):
                                image
                            default:
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
                        HStack {
                            switch (ImageContent.self != EmptyView.self, TextContent.self != EmptyView.self){
                            case (true, true):
                                image
                            case (true, false):
                                image
                            default:
                                text
                            }
                        }
                        #elseif os(macOS)
                        HStack {
                            switch (ImageContent.self != EmptyView.self, TextContent.self != EmptyView.self){
                            case (true, true):
                                if #available(macOS 26.0, *){
                                    if sheetStyle != .default && toolbarPlacement == .navigation {
                                        image
                                            .accessibilityHidden(true)
                                    } else {
                                        text
                                    }
                                }else{
                                    text
                                }
                            case (true, false):
                                image
                            default:
                                text
                            }
                        }
                        #elseif os(tvOS)
                        HStack {
                            switch (ImageContent.self != EmptyView.self, TextContent.self != EmptyView.self){
                            case (true, false):
                                image
                            default:
                                text
                            }
                        }
                        #elseif os(visionOS)
                        HStack {
                            switch (ImageContent.self != EmptyView.self, TextContent.self != EmptyView.self){
                            case (true, true):
                                if toolbarPlacement == .navigation{
                                    image
                                }else{
                                    text
                                }
                            case (true, false):
                                image
                            default:
                                text
                            }
                        }
                        #else
                        HStack {
                            switch (ImageContent.self != EmptyView.self, TextContent.self != EmptyView.self){
                            case (true, true):
                                if toolbarPlacement == .navigation{
                                    if #available(iOS 26.0, *) {
                                        ZStack{
                                            text
                                                .opacity(0)
                                                .frame(width: 0, height: 0)
                                            image
                                                .accessibilityHidden(true)
                                        }
                                    } else {
                                        HStack {
                                            image
                                                .accessibilityHidden(true)
                                            text
                                        }
                                    }
                                }else{
                                    text
                                }
                            case (true, false):
                                image
                            default:
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
        .accessibilityLabel(accessibilityLabel)
        .accessibilityAddTraits(destination == nil ? .isButton : .isLink)
        .accessibilityRemoveTraits(destination == nil ? .isLink : .isButton)
    }

    public init(text: () -> TextContent, image: () -> ImageContent, action: @escaping @MainActor () -> Void) {
        self.text = text()
        self.image = image()
        self.action = action
        self.destination = nil
        // Derive default accessibility label from text or image
        if TextContent.self == Text.self, let t = self.text as? Text {
            self.accessibilityLabel = t
        } else if ImageContent.self != EmptyView.self {
            // Image-only or mixed content without textual label
            self.accessibilityLabel = Text(verbatim: SKTranslation.SKButton.noDescription.value)
        } else {
            self.accessibilityLabel = Text(verbatim: SKTranslation.SKButton.noDescription.value)
        }
    }

    public init(text: () -> TextContent, image: () -> ImageContent, destination: URL) {
        self.text = text()
        self.image = image()
        self.action = {}
        self.destination = destination
        // Derive default accessibility label from text or image
        if TextContent.self == Text.self, let t = self.text as? Text {
            self.accessibilityLabel = t
        } else if ImageContent.self != EmptyView.self {
            // Image-only or mixed content without textual label
            self.accessibilityLabel = Text(verbatim: SKTranslation.SKButton.noDescription.value)
        } else {
            self.accessibilityLabel = Text(verbatim: SKTranslation.SKButton.noDescription.value)
        }
    }

    public init(text: () -> TextContent, action: @escaping @MainActor () -> Void) where ImageContent == EmptyView {
        self.text = text()
        self.image = EmptyView()
        self.action = action
        self.destination = nil
        if TextContent.self == Text.self, let t = self.text as? Text {
            self.accessibilityLabel = t
        } else {
            self.accessibilityLabel = Text(verbatim: SKTranslation.SKButton.noDescription.value)
        }
    }

    public init(text: () -> TextContent, destination: URL) where ImageContent == EmptyView {
        self.text = text()
        self.image = EmptyView()
        self.action = {}
        self.destination = destination
        if TextContent.self == Text.self, let t = self.text as? Text {
            self.accessibilityLabel = t
        } else {
            self.accessibilityLabel = Text(verbatim: SKTranslation.SKButton.noDescription.value)
        }
    }

    public init(image: () -> ImageContent, accessibilityLabel: Text? = nil, action: @escaping @MainActor () -> Void) where TextContent == EmptyView {
        self.text = EmptyView()
        self.image = image()
        self.action = action
        self.destination = nil
        if let accessibilityLabel {
            self.accessibilityLabel = accessibilityLabel
        } else {
            self.accessibilityLabel = Text(verbatim: SKTranslation.SKButton.noDescription.value)
        }
    }

    public init(image: () -> ImageContent, accessibilityLabel: Text? = nil, destination: URL) where TextContent == EmptyView {
        self.text = EmptyView()
        self.image = image()
        self.action = {}
        self.destination = destination
        if let accessibilityLabel {
            self.accessibilityLabel = accessibilityLabel
        } else {
            self.accessibilityLabel = Text(verbatim: SKTranslation.SKButton.noDescription.value)
        }
    }
}

extension SKButton {
    public init(verbatim: String, action: @escaping @MainActor () -> Void) where TextContent == Text, ImageContent == EmptyView {
        self.init(text: { Text(verbatim: verbatim) }, action: action)
    }
    public init(verbatim: String, systemImage: String, action: @escaping @MainActor () -> Void)  where TextContent == Text, ImageContent == Image {
        self.init(text: { Text(verbatim: verbatim) }, image: { Image(systemName: systemImage) }, action: action)
    }
    public init(verbatim: String, image: Image, action: @escaping @MainActor () -> Void) where TextContent == Text, ImageContent == Image {
        self.init(text: { Text(verbatim: verbatim) }, image: { image }, action: action)
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
    public init(systemImage: String, accessibilityLabel: Text? = nil, action: @escaping @MainActor () -> Void) where TextContent == EmptyView, ImageContent == Image {
        self.init(image: { Image(systemName: systemImage) }, accessibilityLabel: accessibilityLabel, action: action)
    }
    public init(systemImage: String, accessibilityLabel: String, action: @escaping @MainActor () -> Void) where TextContent == EmptyView, ImageContent == Image {
        self.init(image: { Image(systemName: systemImage) }, accessibilityLabel: Text(verbatim: accessibilityLabel), action: action)
    }
    public init(systemImage: String, accessibilityLabel: LocalizedStringKey, action: @escaping @MainActor () -> Void) where TextContent == EmptyView, ImageContent == Image {
        self.init(image: { Image(systemName: systemImage) }, accessibilityLabel: Text(accessibilityLabel), action: action)
    }
    public init(image: Image, accessibilityLabel: Text? = nil, action: @escaping @MainActor () -> Void) where TextContent == EmptyView, ImageContent == Image {
        self.init(image: { image }, accessibilityLabel: accessibilityLabel, action: action)
    }
    public init(image: Image, accessibilityLabel: String, action: @escaping @MainActor () -> Void) where TextContent == EmptyView, ImageContent == Image {
        self.init(image: { image }, accessibilityLabel: Text(verbatim: accessibilityLabel), action: action)
    }
    public init(image: Image, accessibilityLabel: LocalizedStringKey, action: @escaping @MainActor () -> Void) where TextContent == EmptyView, ImageContent == Image {
        self.init(image: { image }, accessibilityLabel: Text(accessibilityLabel), action: action)
    }

    public init(verbatim: String, destination: URL) where TextContent == Text, ImageContent == EmptyView {
        self.init(text: { Text(verbatim: verbatim) }, destination: destination)
    }
    public init(verbatim: String, systemImage: String, destination: URL) where TextContent == Text, ImageContent == Image {
        self.init(text: { Text(verbatim: verbatim) }, image: { Image(systemName: systemImage) }, destination: destination)
    }
    public init(verbatim: String, image: Image, destination: URL) where TextContent == Text, ImageContent == Image {
        self.init(text: { Text(verbatim: verbatim) }, image: { image }, destination: destination)
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
    public init(systemImage: String, accessibilityLabel: Text? = nil, destination: URL) where TextContent == EmptyView, ImageContent == Image {
        self.init(image: { Image(systemName: systemImage) }, accessibilityLabel: accessibilityLabel, destination: destination)
    }
    public init(systemImage: String, accessibilityLabel: String, destination: URL) where TextContent == EmptyView, ImageContent == Image {
        self.init(image: { Image(systemName: systemImage) }, accessibilityLabel: Text(verbatim: accessibilityLabel), destination: destination)
    }
    public init(systemImage: String, accessibilityLabel: LocalizedStringKey, destination: URL) where TextContent == EmptyView, ImageContent == Image {
        self.init(image: { Image(systemName: systemImage) }, accessibilityLabel: Text(accessibilityLabel), destination: destination)
    }
    public init(image: Image, accessibilityLabel: Text? = nil, destination: URL) where TextContent == EmptyView, ImageContent == Image {
        self.init(image: { image }, accessibilityLabel: accessibilityLabel, destination: destination)
    }
    public init(image: Image, accessibilityLabel: String, destination: URL) where TextContent == EmptyView, ImageContent == Image {
        self.init(image: { image }, accessibilityLabel: Text(verbatim: accessibilityLabel), destination: destination)
    }
    public init(image: Image, accessibilityLabel: LocalizedStringKey, destination: URL) where TextContent == EmptyView, ImageContent == Image {
        self.init(image: { image }, accessibilityLabel: Text(accessibilityLabel), destination: destination)
    }
    
    public func skButtonStyle(_ style: SKToolbarItemPlacement? = nil) -> SKComponent{
        SKCustomView(type: .customView) {
            self.environment(\.skToolbarPlacement, style)
        }

    }
}

