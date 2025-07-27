//
//  SKButtonStylesMACOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 26/07/2025.
//
#if os(macOS)
import SwiftUI

struct SKPrimaryButtonStyleMACOS: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    @Environment(\.accentColor) private var accentColor: Color
    func makeBody(configuration: Configuration) -> some View {

        configuration.label
            .buttonStyle(.plain)
            .frame(minWidth: 105)
            .if{ content in
                if #available(macOS 26.0, *){
                    content
                        .fontWeight(.medium)
                        .foregroundStyle(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 11)
                        .glassEffect(.regular.tint(accentColor).interactive(true))
                        .opacity(configuration.isPressed ? 0.5 : 1)
                }else{
                    content
                        .padding(.vertical, 1)
                        .padding(.horizontal, 4)
                }
            }
            .opacity(isEnabled ? 1 : 0.5)
            .contentShape(Rectangle())
    }
}

struct SKSecondaryButtonStyleMACOS: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    @Environment(\.accentColor) private var accentColor: Color
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .buttonStyle(.plain)
            .if{ content in
                if #available(macOS 26.0, *){
                    content
                        .frame(minWidth: 105)
                        .fontWeight(.medium)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 11)
                        .glassEffect(.regular.interactive(true))
                        .opacity(configuration.isPressed ? 0.5 : 1)
                }else{
                    content
                        .padding(.vertical, 1)
                        .padding(.horizontal, 4)
                }
            }
            .opacity(isEnabled ? 1 : 0.5)
            .contentShape(Rectangle())
    }
}

struct SKNoteButtonStyleMACOS: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.isEnabled) private var isEnabled: Bool
    @Environment(\.accentColor) private var accentColor: Color
    var textAlignment: TextAlignment
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 3.5){
            if #available(macOS 26.0, *){
                Image(systemName: "info.circle.fill")
            }
            configuration.label
                .buttonStyle(.plain)
                .multilineTextAlignment(textAlignment)
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

struct SKNavigationButtonStyleMACOS: ButtonStyle {
    @Environment(\.sheetSize) var sheetSize
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.accentColor) var accentColor
    @Environment(\.isEnabled) private var isEnabled: Bool
    func makeBody(configuration: Configuration) -> some View {
        if sheetSize == .medium{
            configuration.label
                .labelsHidden()
                .buttonStyle(.plain)
                .foregroundStyle(accentColor)
                .if{ content in
                    if #available(macOS 26.0, *){
                        content
                            .padding(.vertical, 13)
                            .padding(.horizontal, 13)
                            .glassEffect(.regular.interactive(true), in: .circle)
                            .opacity(configuration.isPressed ? 0.5 : 1)
                    }else{
                        content
                            .padding(.vertical, 1)
                            .padding(.horizontal, 4)
                    }
                }
                .contentShape(Rectangle())
                .opacity(isEnabled ? 1 : 0.5)
        }else{
            configuration.label
                .buttonStyle(.plain)
                .frame(minWidth: 105)
                .if{ content in
                    if #available(macOS 26.0, *){
                        content
                            .padding(.vertical, 10)
                            .padding(.horizontal, 11)
                            .glassEffect(.regular.interactive(true))
                            .opacity(configuration.isPressed ? 0.5 : 1)
                    }else{
                        content
                            .padding(.vertical, 1)
                            .padding(.horizontal, 4)
                    }
                }
                .contentShape(Rectangle())
                .opacity(isEnabled ? 1 : 0.5)
        }
    }
}

#if DEBUG
#Preview{
    SKButtonStylesPreviewContent()
}
#endif
#endif

