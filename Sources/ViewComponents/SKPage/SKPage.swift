//
//  SKPage.swift
//  SheetKit
//
//  Created by Kamil Szpak on 14/07/2025.
//

import SwiftUI

extension SKPage{
    public struct Data{
        var content: [any SKComponent]
        var alert: SKPage.Alert?
        let toolbar: SKToolbar
        var backgroundStyle: SKPage.BackgroundStyle?
        var pageStyle: SKPage.Style?
        
        init(backgroundStyle: SKPage.BackgroundStyle? = nil, style: SKPage.Style? = nil, alert: SKPage.Alert? = nil, @SKPageBuilder content: () -> [any SKComponent], @SKToolbarBuilder toolbar: () -> [SKToolbarItem]) {
            self.content = content()
            self.backgroundStyle = backgroundStyle
            self.toolbar = SKToolbar(items: toolbar)
            self.pageStyle = style
            self.alert = alert
        }
        init(backgroundStyle: SKPage.BackgroundStyle? = nil, style: SKPage.Style? = nil, alert: SKPage.Alert? = nil, @SKPageBuilder content: () -> [any SKComponent], toolbarItems: [SKToolbarItem]) {
            self.content = content()
            self.backgroundStyle = backgroundStyle
            self.toolbar = SKToolbar(items: toolbarItems)
            self.pageStyle = style
            self.alert = alert
        }
        
        init(backgroundStyle: SKPage.BackgroundStyle? = nil, style: SKPage.Style? = nil, alert: SKPage.Alert? = nil, content: [any SKComponent], @SKToolbarBuilder toolbar: () -> [SKToolbarItem]) {
            self.content = content
            self.backgroundStyle = backgroundStyle
            self.toolbar = SKToolbar(items: toolbar)
            self.pageStyle = style
            self.alert = alert
        }
        init(backgroundStyle: SKPage.BackgroundStyle? = nil, style: SKPage.Style? = nil, alert: SKPage.Alert? = nil, content: [any SKComponent], toolbarItems: [SKToolbarItem]) {
            self.content = content
            self.backgroundStyle = backgroundStyle
            self.toolbar = SKToolbar(items: toolbarItems)
            self.pageStyle = style
            self.alert = alert
        }
    }
    
    public struct BackgroundStyle{
        var lightView: AnyView
        let darkView: AnyView
        
        
        public init(@ViewBuilder lightView: () -> some View, @ViewBuilder darkView: () -> some View) {
            self.lightView = AnyView(lightView())
            self.darkView = AnyView(darkView())
        }
        public init(@ViewBuilder content: () -> some View) {
            self.lightView = AnyView(content())
            self.darkView = AnyView(content())
        }
        public static let list = SKPage.BackgroundStyle{ListColorView()}
        public static let form = SKPage.BackgroundStyle{ListColorView()}
        
        private struct ListColorView: View {
            @Environment(\.colorScheme) var colorScheme
            var body: some View {
                #if os(iOS)
                if colorScheme == .light{
                    Color.white
                }else{
                    Color(red: 0.109375, green: 0.109375, blue: 0.1176470588)
                }
                #elseif os(tvOS)
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .ignoresSafeArea()
                #else
                    Color.clear
                #endif
            }
        }
        private struct FormColorView: View {
            @Environment(\.colorScheme) var colorScheme
            var body: some View {
                #if os(iOS)
                if colorScheme == .light{
                    Color(red: 0.949, green: 0.949, blue: 0.969)
                }else{
                    Color(red: 0.109375, green: 0.109375, blue: 0.1176470588)
                }
                #elseif os(tvOS)
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .ignoresSafeArea()
                #else
                    Color.clear
                #endif
            }
        }
    }

    public enum Style{
        case plain
        case `default`
    }
    
    public struct Alert{
        let title: String
        let description: String
        let content: AnyView
        let type: AlertType?
        var isPresented: Binding<Bool>
        
        public init(isPresented: Binding<Bool>, title: String, description: String, type: AlertType? = nil, @ViewBuilder content: @escaping () -> some View) {
            self.isPresented = isPresented
            self.title = title
            self.description = description
            self.type = type
            self.content = AnyView(content())
        }
        
        public enum AlertType{
            case confirmation
            case dismissal
        }
    }
}

public struct SKPage: View, SKPageable{
    public var data: SKPage.Data
    public var adjustedContent: AnyView?
    public var body: some View {
        if let adjustedContent{
            adjustedContent
        }else{
            #if os(iOS)
            SKPageIOS(data: data)
            #elseif os(macOS)
            SKPageMACOS(data: data)
            #elseif os(tvOS)
            SKPageTVOS(data: data)
            #elseif os(visionOS)
            SKPageVISIONOS(data: data)
            #elseif os(watchOS)
            SKPageWATCHOS(data: data)
            #else
            EmptyView()
            #endif
        }
    }
    
    public init(@SKPageBuilder content: () -> [any SKComponent], @SKToolbarBuilder toolbar: () -> [SKToolbarItem]) {
        self.data = .init(content: content, toolbar: toolbar)
    }
    
    public init(@SKPageBuilder content: () -> [any SKComponent]) {
        self.data = .init(content: content, toolbar: {})
    }
    public init(data: SKPage.Data) {
        self.data = data
    }
    public init(data: SKPage.Data, @ViewBuilder content: @escaping () -> some View) {
        self.data = data
        self.adjustedContent = AnyView(content())
    }
}
