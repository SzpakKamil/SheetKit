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
        ZStack(alignment: .bottom) {
            backgroundColor
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: skRowSpacing){
                    content()
                }
                .padding(.top, 55)
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
                            }
                            .ignoresSafeArea()
                            .frame(maxWidth: .infinity)
                            .background(.bar)
                        }
                }
            }


        }
    }

    init(backgroundStyle: SKPage.BackgroundStyle, toolbar: SKToolbar, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.backgroundStyle = backgroundStyle
        self.toolbar = toolbar
    }
}
#endif
