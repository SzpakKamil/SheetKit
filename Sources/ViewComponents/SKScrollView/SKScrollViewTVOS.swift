//
//  SKScrollViewTVOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 14/07/2025.
//

import SwiftUI

#if os(tvOS)
struct SKScrollViewTVOS<Content: View>: View {
    @Environment(\.colorScheme) var colorScheme
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
                content()
                    .padding(.horizontal, 30)
                    .padding(.top, 55)
                    .padding(.bottom, toolbarHeight + 10)
            }

            ZStack(alignment: .bottom) {
                Blur()
                    .frame(height: toolbarHeight + 30)
                    
                GeometryReader{ proxy in
                    VStack{
                        Spacer()
                        toolbar
                            .padding(.horizontal, 30)
                            .padding(.bottom, 30)
                            .onGeometryChange(for: CGSize.self) { proxy in
                                proxy.size
                            } action: {
                                self.toolbarHeight = $0.height
                            }
                    }
                }
            }
            .ignoresSafeArea()
            .frame(maxWidth: .infinity)
        }
    }

    init(backgroundStyle: SKPage.BackgroundStyle, toolbar: SKToolbar, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.backgroundStyle = backgroundStyle
        self.toolbar = toolbar
    }
}
#endif
