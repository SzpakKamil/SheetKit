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
    let backgroundStyle: SKPageBackgroundStyle
    let pageStyle: SKPageStyle
    let showBlur: Bool?
    let opacity: CGFloat?
    let showAsInset: Bool?
    let toolbarAnimations: Animation?
    let animationValue: Bool?
    let toolbar: SKToolbar


    var body: some View {
        #if os(iOS)
        SKScrollViewIOS(pageStyle: pageStyle, backgroundStyle: backgroundStyle, showBlur: showBlur,  toolbar: toolbar,  opacity: opacity, toolbarAnimations: toolbarAnimations, animationValue: animationValue, content: content)
        #elseif os(macOS)
        SKScrollViewMACOS(pageStyle: pageStyle, backgroundStyle: backgroundStyle,  toolbar: toolbar, opacity: opacity, toolbarAnimations: toolbarAnimations, animationValue: animationValue, content: content)
        #elseif os(tvOS)
        SKScrollViewTVOS(pageStyle: pageStyle, backgroundStyle: backgroundStyle, toolbar: toolbar, showAsInset: showAsInset, opacity: opacity, toolbarAnimations: toolbarAnimations, animationValue: animationValue, content: content)
        #elseif os(visionOS)
        SKScrollViewVISIONOS(pageStyle: pageStyle, backgroundStyle: backgroundStyle, showBlur: showBlur, showAsInset: showAsInset,  toolbar: toolbar, opacity: opacity, toolbarAnimations: toolbarAnimations, animationValue: animationValue, content: content)
        #elseif os(watchOS)
        SKScrollViewWATCHOS(pageStyle: pageStyle, backgroundStyle: backgroundStyle,  toolbar: toolbar, opacity: opacity, toolbarAnimations: toolbarAnimations, animationValue: animationValue, content: content)
        #else
        EmptyView()
        #endif
    }

    init(pageStyle: SKPageStyle, backgroundStyle: SKPageBackgroundStyle, toolbar: SKToolbar, showBlur: Bool? = nil, showAsInset: Bool? = nil, opacity: CGFloat? = nil,  toolbarAnimations: Animation? = nil, animationValue: Bool? = nil, @ViewBuilder content: @escaping () -> Content) {
        self.pageStyle = pageStyle
        self.content = content
        self.backgroundStyle = backgroundStyle
        self.animationValue = animationValue
        self.showAsInset = showAsInset
        self.showBlur = showBlur
        self.opacity = opacity
        self.toolbarAnimations = toolbarAnimations
        self.toolbar = toolbar
    }
}
