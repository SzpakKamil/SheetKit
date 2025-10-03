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
    @Environment(\.skIsContinueButtonHidden) var skIsContinueButtonHidden
    let content: () -> Content
    let pageStyle: SKPage.Style
    let backgroundStyle: SKPage.BackgroundStyle
    let toolbar: SKToolbar
    @State private var toolbarHeight: CGFloat = 0

    var backgroundColor: Color {
        switch backgroundStyle {
        case .list:
            return colorScheme == .dark ? Color(red: 0.109375, green: 0.109375, blue: 0.1176470588) : .white
        case .form:
            return colorScheme == .dark ? Color(red: 0.109375, green: 0.109375, blue: 0.1176470588) : Color(red: 0.949, green: 0.949, blue: 0.969)
        case .plain:
            return .clear
        case .custom(let light, let dark):
            return colorScheme == .dark ? dark : light
        }
    }

    var body: some View {
        ZStack{
            backgroundColor
                .ignoresSafeArea()

            Group{
                if pageStyle == .default{
                    ScrollView {
                        content()
                    }
                    .scrollBounceBehavior(.basedOnSize)
                }else{
                    content()
                        .frame(maxHeight: .infinity)
                }
            }
            .if{ content in
                if #available(iOS 26.0, *){
                    content
                        #if compiler(>=6.2)
                        .safeAreaBar(edge: .bottom) {
                            toolbar
                                .padding(.horizontal, 30)
                                .padding(.bottom, 30)
                        }
                        #endif
                }else{
                    content
                        .safeAreaInset(edge: .bottom) {
                            toolbar
                                .padding(.horizontal, 30)
                                .padding(.bottom, 30)
                                .frame(maxWidth: .infinity)
                                .background(.ultraThinMaterial)
                                .opacity(toolbar.items.filter{ $0.placement != .navigation}.isEmpty && skIsContinueButtonHidden ? 0 : 1)
                        }
                }
            }
            .ignoresSafeArea(edges: .bottom)
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
