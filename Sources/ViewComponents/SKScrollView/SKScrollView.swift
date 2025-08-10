//
//  SKScrollView.swift
//  SheetKit
//
//  Created by Kamil Szpak on 14/07/2025.
//

import SwiftUI

public struct SKScrollView<Content: View>: View {
    @Environment(\.colorScheme) var colorScheme
    public let content: () -> Content
    public let backgroundStyle: SKPage.BackgroundStyle
    public let toolbar: SKToolbar


    public var body: some View {
        #if os(iOS)
        SKScrollViewIOS(backgroundStyle: backgroundStyle, toolbar: toolbar, content: content)
        #elseif os(macOS)
        SKScrollViewMACOS(backgroundStyle: backgroundStyle, toolbar: toolbar, content: content)
        #elseif os(tvOS)
        SKScrollViewTVOS(backgroundStyle: backgroundStyle, toolbar: toolbar, content: content)
        #elseif os(visionOS)
        SKScrollViewVISIONOS(backgroundStyle: backgroundStyle, toolbar: toolbar, content: content)
        #elseif os(watchOS)
        SKScrollViewWATCHOS(backgroundStyle: backgroundStyle, toolbar: toolbar, content: content)
        #else
        EmptyView()
        #endif
    }

    public init(backgroundStyle: SKPage.BackgroundStyle, toolbar: SKToolbar, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.backgroundStyle = backgroundStyle
        self.toolbar = toolbar
    }
}
