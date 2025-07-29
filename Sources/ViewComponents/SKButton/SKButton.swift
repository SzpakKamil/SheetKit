//
//  SKButton.swift
//  SheetKit
//
//  Created by Kamil Szpak on 29/07/2025.
//

import SwiftUI

public struct SKButton: View {
    @Environment(\.skToolbarPlacement) var toolbarPlacement
    @Environment(\.primaryAction) var primaryAction
    @Environment(\.navigationAction) var navigationAction
    @Environment(\.isEnabled) var isEnabled
    @Environment(\.accentColor) var accentColor
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.skSheetSize) var sheetSize
    private let action: () -> Void
    private let text: AnyView?
    private let image: AnyView?
    private let destination: URL?
    
    public var body: some View {
        Group{
            if let destination{
                Link(destination: destination) {
                    #if !os(iOS)
                    if let image, sheetSize == .medium && toolbarPlacement == .navigation{
                        image
                            .accessibilityHidden(true)
                    }else {
                        text
                    }
                    #else
                    HStack{
                        if let image, toolbarPlacement == .navigation{
                            if #available(iOS 26.0, *){
                                image
                                    .accessibilityHidden(true)
                            }else{
                                HStack{
                                    image
                                        .accessibilityHidden(true)
                                    text
                                }
                            }
                        }else {
                            text
                        }
                    }
                    #endif
                }
            }else{
                Button{
                    action()
                    switch toolbarPlacement{
                    case .primary:
                        primaryAction()
                    case .navigation:
                        navigationAction()
                    default:
                        break
                    }
                }label: {
                    #if os(visionOS)
                    if let image, toolbarPlacement == .navigation{
                        image
                    }else {
                        text
                    }
                    #elseif !os(iOS)
                    if let image, sheetSize == .medium && toolbarPlacement == .navigation{
                        image
                            .accessibilityHidden(true)
                    }else {
                        text
                    }
                    #else
                    HStack{
                        if let image, toolbarPlacement == .navigation{
                            if #available(iOS 26.0, *){
                                image
                            }else{
                                HStack{
                                    image
                                        .accessibilityHidden(true)
                                    text
                                }
                            }
                        }else {
                            text
                        }
                    }
                    #endif
                }
            }
        }
        .if{ content in
            switch toolbarPlacement{
            case .primary: content.buttonStyle(SKPrimaryButtonStyle(isEnabled: isEnabled, accentColor: accentColor, colorScheme: colorScheme))
            case .secondary: content.buttonStyle(SKSecondaryButtonStyle(isEnabled: isEnabled, accentColor: accentColor))
            case .navigation: content.buttonStyle(SKNavigationButtonStyle(colorScheme: colorScheme, sheetSize: sheetSize, isEnabled: isEnabled, accentColor: accentColor))
            case .note: content.buttonStyle(SKNoteButtonStyle(isEnabled: isEnabled, accentColor: accentColor, colorScheme: colorScheme))
            default: content.buttonStyle(SKPrimaryButtonStyle(isEnabled: isEnabled, accentColor: accentColor, colorScheme: colorScheme))
            }
        }
    }
    
    public init(text: () -> some View, image: () -> some View, action: @escaping @MainActor () -> Void){
        self.text = AnyView(text())
        self.image = AnyView(image())
        self.action = action
        self.destination = nil
    }
    
    public init(text: () -> some View, image: () -> some View, destination: URL){
        self.text = AnyView(text())
        self.image = AnyView(image())
        self.action = {}
        self.destination = destination
    }
    
    public init(text: () -> some View, action: @escaping @MainActor () -> Void){
        self.text = AnyView(text())
        self.image = nil
        self.action = action
        self.destination = nil
    }
    
    public init(text: () -> some View, destination: URL){
        self.text = AnyView(text())
        self.image =  nil
        self.action = {}
        self.destination = destination
    }
    
    public init(image: () -> some View, action: @escaping @MainActor () -> Void){
        self.text = nil
        self.image = AnyView(image())
        self.action = action
        self.destination = nil
    }
    
    public init(image: () -> some View, destination: URL){
        self.text = nil
        self.image = AnyView(image())
        self.action = {}
        self.destination = destination
    }
}

extension SKButton{
    public init(_ title: String, action: @escaping @MainActor () -> Void){
        self.init(text: {Text(verbatim: title)}, action: action)
    }
    public init(_ title: String, systemImage: String, action: @escaping @MainActor () -> Void){
        self.init(text: {Text(verbatim: title)}, image: {Image(systemName: systemImage)}, action: action)
    }
    public init(_ title: String, image: Image, action: @escaping @MainActor () -> Void){
        self.init(text: {Text(verbatim: title)}, image: {image}, action: action)
    }
    public init(_ titleKey: LocalizedStringKey, action: @escaping @MainActor () -> Void){
        self.init(text: {Text(titleKey)}, action: action)
    }
    public init(_ titleKey: LocalizedStringKey, systemImage: String, action: @escaping @MainActor () -> Void){
        self.init(text: {Text(titleKey)}, image: {Image(systemName: systemImage)}, action: action)
    }
    public init(_ titleKey: LocalizedStringKey, image: Image, action: @escaping @MainActor () -> Void){
        self.init(text: {Text(titleKey)}, image: {image}, action: action)
    }
    public init(systemImage: String, action: @escaping @MainActor () -> Void){
        self.init(image: {Image(systemName: systemImage)}, action: action)
    }
    public init(image: Image, action: @escaping @MainActor () -> Void){
        self.init(image: {image}, action: action)
    }
    
    public init(_ title: String, destination: URL){
        self.init(text: {Text(verbatim: title)}, destination: destination)
    }
    public init(_ title: String, systemImage: String, destination: URL){
        self.init(text: {Text(verbatim: title)}, image: {Image(systemName: systemImage)}, destination: destination)
    }
    public init(_ title: String, image: Image, destination: URL){
        self.init(text: {Text(verbatim: title)}, image: {image}, destination: destination)
    }
    public init(_ titleKey: LocalizedStringKey, destination: URL){
        self.init(text: {Text(titleKey)}, destination: destination)
    }
    public init(_ titleKey: LocalizedStringKey, systemImage: String, destination: URL){
        self.init(text: {Text(titleKey)}, image: {Image(systemName: systemImage)}, destination: destination)
    }
    public init(_ titleKey: LocalizedStringKey, image: Image, destination: URL){
        self.init(text: {Text(titleKey)}, image: {image}, destination: destination)
    }
    public init(systemImage: String, destination: URL){
        self.init(image: {Image(systemName: systemImage)}, destination: destination)
    }
    public init(image: Image, destination: URL){
        self.init(image: {image}, destination: destination)
    }
}

#Preview {
    SKToolbarItem(placement: .primary) {
        SKButton("Note Button", systemImage: "house") { }
    }
    .environment(\.skSheetSize, .medium)
}
