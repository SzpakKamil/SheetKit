//
//  SwiftUIView.swift
//  SheetKit
//
//  Created by Kamil Szpak on 14/07/2025.
//

import SwiftUI

public struct SKScrollView<Content: View>: View {
    @Environment(\.colorScheme) var colorScheme
    public let content: () -> Content
    public let backgroundStyle: SKPage.BackgroundStyle
    public let toolbar: SKToolbar
    @State private var toolbarHeight: CGFloat = 0

    var backgroundColor: Color {
        #if os(macOS) || os(tvOS)
        switch backgroundStyle {
        case .custom(let light, let dark):
            return colorScheme == .dark ? dark : light
        default:
            return .clear
        }
        #else
        switch backgroundStyle {
        case .list:
            return colorScheme == .dark ? .clear : .white
        case .form:
            return colorScheme == .dark ? .clear : Color(red: 0.949, green: 0.949, blue: 0.969)
        case .custom(let light, let dark):
            return colorScheme == .dark ? dark : light
        }
        #endif
    }

    public var body: some View {
        ZStack(alignment: .bottom) {
            backgroundColor
                .ignoresSafeArea()

            ScrollView {
                content()
                    #if os(tvOS)
                    .padding(.horizontal, 30)
                    .padding(.top, 55)
                    .padding(.bottom, toolbarHeight + 10)
                    #elseif !os(macOS)
                    .padding(.horizontal, 30)
                    .padding(.bottom, toolbarHeight)
                    #else
                    .padding(.top, 55)
                    .padding(.bottom, toolbarHeight)
                    #endif

            }

            ZStack(alignment: .bottom) {
                #if os(watchOS)
                Color.clear
                #elseif canImport(UIKit)
                VariableBlurView(maxBlurRadius: 20, direction: .blurredBottomClearTop)
                    .frame(height: toolbarHeight + 20)
                #else
                VariableBlurView(material: .windowBackground, blendingMode: .withinWindow, state: .active)
                    .frame(height: toolbarHeight + 20)
                    .mask(alignment: .top) {
                        LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: .black.opacity(0.0), location: 0),
                                .init(color: .black.opacity(0.6), location: 0.1),
                                .init(color: .black.opacity(0.95), location: 0.5),
                                .init(color: .black.opacity(1.0), location: 1.0),
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    }
                #endif
                    
                GeometryReader{ proxy in
                    VStack{
                        Spacer()
                        toolbar
                            .background(Color.clear)
                            #if os(macOS)
                            .padding(.horizontal, 20)
                            .padding(.bottom, 20)
                            #else
                            .padding(.horizontal, 30)
                            .padding(.bottom, 30)
                            #endif
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

    public init(backgroundStyle: SKPage.BackgroundStyle, toolbar: SKToolbar, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.backgroundStyle = backgroundStyle
        self.toolbar = toolbar
    }
}
