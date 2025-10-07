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
    let pageStyle: SKPageStyle
    let backgroundStyle: SKPageBackgroundStyle
    let toolbar: SKToolbar
    let toolbarAnimations: Animation?
    var opacity: CGFloat?
    let animationValue: Bool?
    let showAsInset: Bool?
    @State private var toolbarHeight: CGFloat = 0


    var body: some View {
        ZStack {
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
                            .padding(.bottom, toolbarHeight + 30)
                    }
                    .scrollBounceBehavior(.basedOnSize)
                }else{
                    content()
                        .frame(maxHeight: .infinity)
                }
            }
            .if{ content in
                if showAsInset == true{
                    content
                        .safeAreaInset(edge: .bottom) {
                            toolbar
                                .opacity(opacity ?? 1)
                                .animation(toolbarAnimations, value: animationValue)
                        }
                }else{
                    content
                }
            }
            if showAsInset != true{
                ZStack(alignment: .bottom) {
                    Blur()
                        .frame(height: toolbarHeight + 30)
                        .opacity(0.6)
                    
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
                                .opacity(opacity ?? 1)
                                .animation(toolbarAnimations, value: animationValue)
                        }
                    }
                }
                .ignoresSafeArea()
                .frame(maxWidth: .infinity)
            }
        }
    }
    
    init(pageStyle: SKPageStyle, backgroundStyle: SKPageBackgroundStyle, toolbar: SKToolbar, showAsInset: Bool?, opacity: CGFloat? = nil, toolbarAnimations: Animation?, animationValue: Bool?, @ViewBuilder content: @escaping () -> Content) {
        self.pageStyle = pageStyle
        self.content = content
        self.backgroundStyle = backgroundStyle
        self.toolbarAnimations = toolbarAnimations
        self.animationValue = animationValue
        self.opacity = opacity
        self.showAsInset = showAsInset
        self.toolbar = toolbar
    }
}
#endif
