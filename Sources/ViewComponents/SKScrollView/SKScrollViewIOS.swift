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
    let pageStyle: SKPageStyle
    let backgroundStyle: SKPageBackgroundStyle
    let toolbar: SKToolbar
    let showBlur: Bool?
    var opacity: CGFloat?
    let toolbarAnimations: Animation?
    let animationValue: Bool?
    @State private var toolbarHeight: CGFloat = 0

    var body: some View {
        ZStack{
            if colorScheme == .light{
                backgroundStyle.lightView
                    .ignoresSafeArea()
            }else{
                backgroundStyle.darkView
                    .ignoresSafeArea()
            }

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
                                .opacity(opacity ?? 1)
                                .animation(toolbarAnimations, value: animationValue)
                        }
                        #endif
                }else{
                    content
                        .safeAreaInset(edge: .bottom) {
                            if showBlur == true{
                                toolbar
                                    .padding(.horizontal, 30)
                                    .padding(.bottom, 30)
                                    .frame(maxWidth: .infinity)
                                    .background(.ultraThinMaterial)
                                    .opacity(toolbar.items.filter{ $0.placement != .navigation}.isEmpty && skIsContinueButtonHidden ? 0 : 1)
                                    .opacity(opacity ?? 1)
                                    .animation(toolbarAnimations, value: animationValue)
                            }else{
                                toolbar
                                    .padding(.horizontal, 30)
                                    .padding(.bottom, 30)
                                    .frame(maxWidth: .infinity)
                                    .opacity(toolbar.items.filter{ $0.placement != .navigation}.isEmpty && skIsContinueButtonHidden ? 0 : 1)
                                    .opacity(opacity ?? 1)
                                    .animation(toolbarAnimations, value: animationValue)
                            }
                        }
                }
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }

    init(pageStyle: SKPageStyle, backgroundStyle: SKPageBackgroundStyle, showBlur: Bool? = nil, toolbar: SKToolbar, opacity: CGFloat? = nil, toolbarAnimations: Animation?, animationValue: Bool?, @ViewBuilder content: @escaping () -> Content) {
        self.pageStyle = pageStyle
        self.content = content
        self.backgroundStyle = backgroundStyle
        self.showBlur = showBlur
        self.toolbar = toolbar
        self.opacity = opacity
        self.toolbarAnimations = toolbarAnimations
        self.animationValue = animationValue
    }
}
#endif
