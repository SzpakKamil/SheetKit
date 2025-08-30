//
//  SKScrollViewMACOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 14/07/2025.
//

import SwiftUI

#if os(macOS)
struct SKScrollViewMACOS<Content: View>: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.skSheetStyle) var sheetStyle
    @Environment(\.skRowSpacing) var skRowSpacing
    let content: () -> Content
    let pageStyle: SKPage.Style
    let backgroundStyle: SKPage.BackgroundStyle
    let toolbar: SKToolbar
    @State private var toolbarHeight: CGFloat = 0

    var backgroundColor: Color {
        switch backgroundStyle {
        case .custom(let light, let dark):
            return colorScheme == .dark ? dark : light
        default:
            return .clear
        }
    }

    var body: some View {
        ZStack {
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
                if #available(macOS 26.0, *){
                    content
                        #if compiler(>=6.2)
                        .safeAreaBar(edge: .bottom) {
                            toolbar
                                .padding(.horizontal, 20)
                                .padding(.bottom, 20)
                        }
                        #endif
                }else{
                    content
                        .safeAreaInset(edge: .bottom) {
                            VStack(spacing: 0){
                                toolbar
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .padding(.horizontal, 15)
                                    .padding(.bottom, 15)
                                    .padding(.top, 10)
                            }
                            .ignoresSafeArea()
                            .frame(maxWidth: .infinity)
                            .background(.bar)
                        }
                }
            }


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
