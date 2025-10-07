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
    let toolbarAnimations: Animation?
    let showBlur: Bool?
    let animationValue: Bool?
    var opacity: CGFloat?
    let showAsInset: Bool?
    @State private var toolbarHeight: CGFloat = 0
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
                }
                .scrollBounceBehavior(.basedOnSize)
            }else{
                if showAsInset == true{
                    content()
                        .frame(maxHeight: .infinity)
                        .safeAreaInset(edge: .bottom) {
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
                }else{
                    content()
                        .frame(maxHeight: .infinity)
                }
                    
            }
            
            if showAsInset == false{
                ZStack(alignment: .bottom) {
                    if showBlur != false{
                        Blur()
                            .frame(height: toolbarHeight + 30)
                    }
                    
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

    init(pageStyle: SKPage.Style, backgroundStyle: SKPage.BackgroundStyle, showBlur: Bool? = nil,  showAsInset: Bool? = nil, toolbar: SKToolbar, opacity: CGFloat? = nil, toolbarAnimations: Animation?, animationValue: Bool?, @ViewBuilder content: @escaping () -> Content) {
        self.pageStyle = pageStyle
        self.content = content
        self.backgroundStyle = backgroundStyle
        self.showAsInset = showAsInset
        self.showBlur = showBlur
        self.toolbar = toolbar
        self.opacity = opacity
        self.toolbarAnimations = toolbarAnimations
        self.animationValue = animationValue
    }
}
#endif
