//
//  SKButtonStylesWATCHOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 26/07/2025.
//

import SwiftUI

#if os(watchOS)
struct SKPrimaryButtonStyleWATCHOS: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    @Environment(\.accentColor) private var accentColor: Color
    func makeBody(configuration: Configuration) -> some View {
        HStack{
            Spacer()
            configuration.label
                .buttonStyle(.plain)
            Spacer()
        }
        .foregroundStyle(.white)
        .if{ content in
            if #available(watchOS 26.0, *){
                content
                    .fontWeight(.medium)
                    .padding(.vertical, 17)
                    .glassEffect(.regular.tint(accentColor).interactive(true))
            }else{
                content
                    .fontWeight(.medium)
                    .padding(.vertical, 17)
                    .background(accentColor)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    .opacity( configuration.isPressed ? 0.5 : 1)
            }
        }
        .opacity(isEnabled ? 1 : 0.5)
        .contentShape(Rectangle())
    }
}

struct SKSecondaryButtonStyleWATCHOS: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    @Environment(\.accentColor) private var accentColor: Color
    func makeBody(configuration: Configuration) -> some View {
        HStack{
            Spacer()
            configuration.label
                .buttonStyle(.plain)
            Spacer()
        }
        .foregroundStyle(accentColor)
        .if{ content in
            if #available(macOS 26.0, iOS 26.0, tvOS 26.0, watchOS 26.0, *){
                content
                    .fontWeight(.medium)
                    .padding(.vertical, 17)
                    .glassEffect(.regular.interactive(true))
            }else{
                content
                    .fontWeight(.medium)
                    .padding(.vertical, 13)
                    .background(.clear)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    .opacity( configuration.isPressed ? 0.5 : 1)
            }
            
        }
        .opacity(isEnabled ? 1 : 0.5)
        .contentShape(Rectangle())
    }
}

struct SKNoteButtonStyleWATCHOS: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.isEnabled) private var isEnabled: Bool
    @Environment(\.accentColor) private var accentColor: Color
    var textAlignment: TextAlignment
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 3.5){
            if #available(watchOS 26.0, *){
                Image(systemName: "info.circle.fill")
            }
            configuration.label
                .buttonStyle(.plain)
                .multilineTextAlignment(textAlignment)
                .font(.footnote)
        }
        .foregroundStyle(accentColor)
        .lineLimit(1)
        .opacity(configuration.isPressed ? 0.5 : 1)
        .contentShape(Rectangle())
        .opacity(isEnabled ? 1 : 0.5)
    }
    
    init(textAlignment: TextAlignment = .leading) {
        self.textAlignment = textAlignment
    }
}

struct SKNavigationButtonStyleWATCHOS: ButtonStyle {
    @Environment(\.sheetSize) var sheetSize
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.accentColor) var accentColor
    @Environment(\.isEnabled) private var isEnabled: Bool
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .labelsHidden()
            .foregroundStyle(accentColor)
            .contentShape(Rectangle())
    }
}

#if DEBUG
#Preview{
    SKButtonStylesPreviewContent()
}
#endif

#endif
