//
//  SKScrollView.swift
//  SheetKit
//
//  Created by Kamil Szpak on 14/07/2025.
//

import SwiftUI

struct SKScrollView<Content: View>: View {
    @Environment(\.colorScheme) var colorScheme
    let content: () -> Content
    let backgroundStyle: SKPage.BackgroundStyle
    let toolbar: SKToolbar


    var body: some View {
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

    init(backgroundStyle: SKPage.BackgroundStyle, toolbar: SKToolbar, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.backgroundStyle = backgroundStyle
        self.toolbar = toolbar
    }
}
