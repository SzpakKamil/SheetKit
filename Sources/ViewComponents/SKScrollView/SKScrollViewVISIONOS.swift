//
//  SKScrollViewVISIONOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 14/07/2025.
//

import SwiftUI

#if os(visionOS)
struct SKScrollViewVISIONOS<Content: View>: View {
    @Environment(\.colorScheme) var colorScheme
    let content: () -> Content
    let pageStyle: SKPage.Style
    let backgroundStyle: SKPage.BackgroundStyle
    let toolbar: SKToolbar
    @State private var toolbarHeight: CGFloat = 0

    var backgroundColor: Color {
        switch backgroundStyle {
        case .list:
            return colorScheme == .dark ? .clear : .white
        case .form:
            return colorScheme == .dark ? .clear : Color(red: 0.949, green: 0.949, blue: 0.969)
        case .plain:
            return .clear
        case .custom(let light, let dark):
            return colorScheme == .dark ? dark : light
        }
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            backgroundColor
                .ignoresSafeArea()
            
            if pageStyle == .default{
                ScrollView {
                    content()
                }
                .scrollBounceBehavior(.basedOnSize)
            }else{
                content()
                    .frame(maxHeight: .infinity)
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

    init(pageStyle: SKPage.Style, backgroundStyle: SKPage.BackgroundStyle, toolbar: SKToolbar, @ViewBuilder content: @escaping () -> Content) {
        self.pageStyle = pageStyle
        self.content = content
        self.backgroundStyle = backgroundStyle
        self.toolbar = toolbar
    }
}
#endif
