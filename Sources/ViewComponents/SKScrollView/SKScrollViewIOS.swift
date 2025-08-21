//
//  SKScrollViewIOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 14/07/2025.
//

import SwiftUI

#if os(iOS)
struct SKScrollViewIOS<Content: View>: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.skRowSpacing) var skRowSpacing
    let content: () -> Content
    let backgroundStyle: SKPage.BackgroundStyle
    let toolbar: SKToolbar
    @State private var toolbarHeight: CGFloat = 0

    var backgroundColor: Color {
        switch backgroundStyle {
        case .list:
            return colorScheme == .dark ? .clear : .white
        case .form:
            return colorScheme == .dark ? .clear : Color(red: 0.949, green: 0.949, blue: 0.969)
        case .custom(let light, let dark):
            return colorScheme == .dark ? dark : light
        }
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            backgroundColor
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: skRowSpacing){
                    content()
                }
                .padding(.horizontal, 30)
            }
            .if{ content in
                if #available(iOS 26.0, *){
                    content
                        .safeAreaBar(edge: .bottom) {
                            toolbar
                                .padding(.horizontal, 30)
                                .padding(.bottom, 30)
                        }
                }else{
                    content
                        .safeAreaInset(edge: .bottom) {
                            toolbar
                                .padding(.horizontal, 30)
                                .padding(.bottom, 30)
                                .background(.ultraThinMaterial)
                        }
                }
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }

    init(backgroundStyle: SKPage.BackgroundStyle, toolbar: SKToolbar, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.backgroundStyle = backgroundStyle
        self.toolbar = toolbar
    }
}
#endif
