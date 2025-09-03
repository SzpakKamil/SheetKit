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

    var backgroundColor: Color {
        switch backgroundStyle {
        case .custom(let light, let dark):
            return colorScheme == .dark ? dark : light
        default:
            return .clear
        }
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            backgroundColor
                .ignoresSafeArea()

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
            
            toolbar
        }
    }

    init(pageStyle: SKPage.Style, backgroundStyle: SKPage.BackgroundStyle, toolbar: SKToolbar, @ViewBuilder content: @escaping () -> Content) {
        self.pageStyle = pageStyle
        self.content = content
        self.backgroundStyle = backgroundStyle
        self.toolbar = toolbar
    }
}
#endif
