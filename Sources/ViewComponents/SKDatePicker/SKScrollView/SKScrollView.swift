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
    let pageStyle: SKPage.Style
    let toolbar: SKToolbar


    var body: some View {
        #if os(iOS)
        SKScrollViewIOS(pageStyle: pageStyle, backgroundStyle: backgroundStyle, toolbar: toolbar, content: content)
        #elseif os(macOS)
        SKScrollViewMACOS(pageStyle: pageStyle, backgroundStyle: backgroundStyle, toolbar: toolbar, content: content)
        #elseif os(tvOS)
        SKScrollViewTVOS(pageStyle: pageStyle, backgroundStyle: backgroundStyle, toolbar: toolbar, content: content)
        #elseif os(visionOS)
        SKScrollViewVISIONOS(pageStyle: pageStyle, backgroundStyle: backgroundStyle, toolbar: toolbar, content: content)
        #elseif os(watchOS)
        SKScrollViewWATCHOS(pageStyle: pageStyle, backgroundStyle: backgroundStyle, toolbar: toolbar, content: content)
        #else
        EmptyView()
        #endif
    }

    init(pageStyle: SKPage.Style, backgroundStyle: SKPage.BackgroundStyle, toolbar: SKToolbar, @ViewBuilder content: @escaping () -> Content) {
        self.pageStyle = pageStyle
        self.content = content
        self.backgroundStyle = backgroundStyle
        self.toolbar = toolbar
    }
}
