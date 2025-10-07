//
//  SKPageBackgroundStyle.swift
//  SheetKit
//
//  Created by Kamil Szpak on 07/10/2025.
//

import SwiftUI

public struct SKPageBackgroundStyle{
    var lightView: AnyView
    let darkView: AnyView
    
    
    public init(@ViewBuilder lightView: () -> some View, @ViewBuilder darkView: () -> some View) {
        self.lightView = AnyView(lightView())
        self.darkView = AnyView(darkView())
    }
    public init(@ViewBuilder content: () -> some View) {
        self.lightView = AnyView(content())
        self.darkView = AnyView(content())
    }
    public static let list = SKPageBackgroundStyle{ListColorView()}
    public static let form = SKPageBackgroundStyle{ListColorView()}
    
    private struct ListColorView: View {
        @Environment(\.colorScheme) var colorScheme
        var body: some View {
#if os(iOS)
            if colorScheme == .light{
                Color.white
            }else{
                Color(red: 0.109375, green: 0.109375, blue: 0.1176470588)
            }
#elseif os(tvOS)
            Rectangle()
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()
#else
            Color.clear
#endif
        }
    }
    private struct FormColorView: View {
        @Environment(\.colorScheme) var colorScheme
        var body: some View {
#if os(iOS)
            if colorScheme == .light{
                Color(red: 0.949, green: 0.949, blue: 0.969)
            }else{
                Color(red: 0.109375, green: 0.109375, blue: 0.1176470588)
            }
#elseif os(tvOS)
            Rectangle()
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()
#else
            Color.clear
#endif
        }
    }
}

