//
//  SKScrollViewWATCHOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 14/07/2025.
//

import SwiftUI

#if os(watchOS)
struct SKScrollViewWATCHOS<Content: View>: View {
    @Environment(\.colorScheme) var colorScheme
    let content: () -> Content
    let pageStyle: SKPage.Style
    let backgroundStyle: SKPage.BackgroundStyle
    let toolbar: SKToolbar
    let toolbarAnimations: Animation?
    let animationValue: Bool?
    var opacity: CGFloat?

    var body: some View {
        ZStack(alignment: .bottom) {
            if colorScheme == .light{
                backgroundStyle.lightView
                    .ignoresSafeArea()
            }else{
                backgroundStyle.darkView
                    .ignoresSafeArea()
            }


            if pageStyle == .default{
                ScrollView {
                    content()
                        .padding(.horizontal, 10)
                }
                .scrollBounceBehavior(.basedOnSize)
            }else{
                content()
                    .frame(maxHeight: .infinity)
            }
            if (animationValue ?? true) == true{
                toolbar
            }
        }
    }

    init(pageStyle: SKPage.Style, backgroundStyle: SKPage.BackgroundStyle, toolbar: SKToolbar, opacity: CGFloat? = nil, toolbarAnimations: Animation?, animationValue: Bool?, @ViewBuilder content: @escaping () -> Content) {
        self.pageStyle = pageStyle
        self.content = content
        self.backgroundStyle = backgroundStyle
        self.opacity = opacity
        self.toolbarAnimations = toolbarAnimations
        self.animationValue = animationValue
        self.toolbar = toolbar
    }
}
#endif
