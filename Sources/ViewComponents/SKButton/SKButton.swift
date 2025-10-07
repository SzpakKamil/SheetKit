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
    @State private var isLoading: Bool = false
    public let type: SKComponentType = .customView
    private let action: (() -> Void)?
    private let actionAsync: (() async ->  Void)?
    private let text: TextContent
    private let accessibilityLabel: Text
    private let image: ImageContent
    private let destination: URL?
    
    
    var borderShape: ButtonBorderShape{
        #if os(iOS)
        if #available(iOS 26.0, *){
            return .capsule
        }else{
            return .roundedRectangle
        }
        #else
        return .buttonBorder
        #endif
    }
    public var body: some View {
        Group {
            if let destination {
                Link(destination: destination) {
                    if isLoading{
                        ProgressView()
                        #if os(macOS)
                            .scaleEffect(0.5)
                            .frame(height: 15)
                        #elseif os(visionOS)
                            .frame(height: 20)
                        #elseif os(tvOS)
                            .scaleEffect(0.75)
                        #elseif os(watchOS)
                            .clipShape(.circle)
                        #endif
                    }else{
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
                                    if toolbarPlacement == .navigation || toolbarPlacement == .dismiss{
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
                .contentShape(Rectangle())
                .buttonBorderShape(borderShape)
            } else {
                Button {
                    if let action{
                        action()
                        toolbarButtonAction()
                    }else if let actionAsync{
                        Task {
                            await MainActor.run { isLoading = true }
                            await actionAsync()
                            await MainActor.run {
                                toolbarButtonAction()
                                isLoading = false
                            }
                        }
                    }
                } label: {
                    if isLoading{
                        ProgressView()
#if os(macOS)
                            .scaleEffect(0.5)
                            .frame(height: 15)
#elseif os(visionOS)
                            .frame(height: 20)
#elseif os(tvOS)
                            .scaleEffect(0.75)
                            .if{content in
                                if #unavailable(tvOS 26.0){
                                    content
                                        .frame(minHeight: 20)
                                }else{
                                    content
                                }
                            }
#elseif os(watchOS)
                            .frame(width: 15)
#endif
                    }else{
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
                                        if sheetStyle != .default && (toolbarPlacement == .navigation || toolbarPlacement == .dismiss) {
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
                                    if toolbarPlacement == .navigation || toolbarPlacement == .dismiss{
                                        image
                                    }else{
                                        text
                                            .padding(.horizontal, 5)
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
                                    if toolbarPlacement == .navigation || toolbarPlacement == .dismiss{
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
                .contentShape(Rectangle())
                .buttonBorderShape(borderShape)
            }
        }
        .if { content in
            #if os(watchOS)
            content
            #else
            switch toolbarPlacement {
            case .primary: content.buttonStyle(SKPrimaryButtonStyle(isEnabled: isEnabled && !isLoading, accentColor: accentColor, sheetStyle: sheetStyle, colorScheme: colorScheme))
            case .secondary: content.buttonStyle(SKSecondaryButtonStyle(sheetStyle: sheetStyle, isEnabled: isEnabled && !isLoading, accentColor: accentColor))
            case .navigation: content.buttonStyle(SKNavigationButtonStyle(colorScheme: colorScheme, sheetStyle: sheetStyle, isEnabled: isEnabled, accentColor: accentColor))
            case .dismiss: content.buttonStyle(SKNavigationButtonStyle(colorScheme: colorScheme, sheetStyle: sheetStyle, isEnabled: isEnabled, accentColor: accentColor))
            case .note: content.buttonStyle(SKNoteButtonStyle(isEnabled: isEnabled && !isLoading, accentColor: accentColor, colorScheme: colorScheme))
            default: content.buttonStyle(SKPrimaryButtonStyle(isEnabled: isEnabled && !isLoading, accentColor: accentColor, sheetStyle: sheetStyle, colorScheme: colorScheme))
            }
            #endif
        }
        .disabled(isLoading || !isEnabled)
        .accessibilityLabel(accessibilityLabel)
        .accessibilityAddTraits(destination == nil ? .isButton : .isLink)
        .accessibilityRemoveTraits(destination == nil ? .isLink : .isButton)
    }

    public init(text: () -> TextContent, image: () -> ImageContent, action: @escaping @MainActor () -> Void) {
        self.text = text()
        self.image = image()
        self.action = action
        self.actionAsync = nil
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
    
    public init(text: () -> TextContent, image: () -> ImageContent, task: @escaping () async -> Void) {
        self.text = text()
        self.image = image()
        self.action = nil
        self.actionAsync = task
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
        self.action = nil
        self.actionAsync = nil
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
        self.actionAsync = nil
        self.destination = nil
        if TextContent.self == Text.self, let t = self.text as? Text {
            self.accessibilityLabel = t
        } else {
            self.accessibilityLabel = Text(verbatim: SKTranslation.SKButton.noDescription.value)
        }
    }
    
    public init(text: () -> TextContent, task: @escaping () async -> Void) where ImageContent == EmptyView {
        self.text = text()
        self.image = EmptyView()
        self.action = nil
        self.actionAsync = task
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
        self.action = nil
        self.actionAsync = nil
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
        self.actionAsync = nil
        self.destination = nil
        if let accessibilityLabel {
            self.accessibilityLabel = accessibilityLabel
        } else {
            self.accessibilityLabel = Text(verbatim: SKTranslation.SKButton.noDescription.value)
        }
    }
    
    public init(image: () -> ImageContent, accessibilityLabel: Text? = nil, task: @escaping () async -> Void) where TextContent == EmptyView {
        self.text = EmptyView()
        self.image = image()
        self.action = nil
        self.actionAsync = task
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
        self.action = nil
        self.actionAsync = nil
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
    
    
    public init(verbatim: String, task: @escaping () async -> Void) where TextContent == Text, ImageContent == EmptyView {
        self.init(text: { Text(verbatim: verbatim) }, task: task)
    }
    public init(verbatim: String, systemImage: String, task: @escaping () async -> Void)  where TextContent == Text, ImageContent == Image {
        self.init(text: { Text(verbatim: verbatim) }, image: { Image(systemName: systemImage) }, task: task)
    }
    public init(verbatim: String, image: Image, task: @escaping () async -> Void) where TextContent == Text, ImageContent == Image {
        self.init(text: { Text(verbatim: verbatim) }, image: { image }, task: task)
    }
    public init(_ titleKey: LocalizedStringKey, task: @escaping () async -> Void)where TextContent == Text, ImageContent == EmptyView {
        self.init(text: { Text(titleKey) }, task: task)
    }
    public init(_ titleKey: LocalizedStringKey, systemImage: String, task: @escaping () async -> Void) where TextContent == Text, ImageContent == Image{
        self.init(text: { Text(titleKey) }, image: { Image(systemName: systemImage) }, task: task)
    }
    public init(_ titleKey: LocalizedStringKey, image: Image, task: @escaping () async -> Void) where TextContent == Text, ImageContent == Image {
        self.init(text: { Text(titleKey) }, image: { image }, task: task)
    }
    public init(systemImage: String, accessibilityLabel: Text? = nil, task: @escaping () async -> Void) where TextContent == EmptyView, ImageContent == Image {
        self.init(image: { Image(systemName: systemImage) }, accessibilityLabel: accessibilityLabel, task: task)
    }
    public init(systemImage: String, accessibilityLabel: String, task: @escaping () async -> Void) where TextContent == EmptyView, ImageContent == Image {
        self.init(image: { Image(systemName: systemImage) }, accessibilityLabel: Text(verbatim: accessibilityLabel), task: task)
    }
    public init(systemImage: String, accessibilityLabel: LocalizedStringKey, task: @escaping () async -> Void) where TextContent == EmptyView, ImageContent == Image {
        self.init(image: { Image(systemName: systemImage) }, accessibilityLabel: Text(accessibilityLabel), task: task)
    }
    public init(image: Image, accessibilityLabel: Text? = nil, task: @escaping () async -> Void) where TextContent == EmptyView, ImageContent == Image {
        self.init(image: { image }, accessibilityLabel: accessibilityLabel, task: task)
    }
    public init(image: Image, accessibilityLabel: String, task: @escaping () async -> Void) where TextContent == EmptyView, ImageContent == Image {
        self.init(image: { image }, accessibilityLabel: Text(verbatim: accessibilityLabel), task: task)
    }
    public init(image: Image, accessibilityLabel: LocalizedStringKey, task: @escaping () async -> Void) where TextContent == EmptyView, ImageContent == Image {
        self.init(image: { image }, accessibilityLabel: Text(accessibilityLabel), task: task)
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
    
    public func skButtonStyle(_ style: SKToolbarItemPlacement? = nil) -> some View{
        self.environment(\.skToolbarPlacement, style)
    }
}

