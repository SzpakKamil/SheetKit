//
//  SKButton.swift
//  SheetKit
//
//  Created by Kamil Szpak on 10/07/2025.
//

import SwiftUI

struct SKPrimaryButton: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    @Environment(\.accentColor) private var accentColor: Color
    func makeBody(configuration: Configuration) -> some View {
        #if os(macOS) || os(tvOS)
        configuration.label
            .buttonStyle(.plain)
            .frame(minWidth: 105)
            .if{ content in
                if #available(macOS 26.0, tvOS 26.0, *){
                    content
                        .fontWeight(.medium)
                        .foregroundStyle(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 11)
                        #if os(tvOS)
                        .glassEffect(.regular.tint(accentColor).interactive(true), in: .rect)
                        .opacity(configuration.isPressed ? 0.5 : 1)
                        .hoverEffect(.highlight)
                        #else
                        .glassEffect(.regular.tint(accentColor).interactive(true))
                        .opacity(configuration.isPressed ? 0.5 : 1)
                        #endif
                }else{
                    content
                        .padding(.vertical, 1)
                        .padding(.horizontal, 4)
                }
            }
            .opacity(isEnabled ? 1 : 0.5)
            .contentShape(Rectangle())
        #else
        HStack{
            Spacer()
            configuration.label
                .buttonStyle(.plain)
            Spacer()
        }
        .foregroundStyle(.white)
        .if{ content in
            #if os(visionOS)
            content
                .fontWeight(.medium)
                .padding(.vertical, 17)
                .background(.tint)
                .hoverEffect(.highlight)
                .clipShape(.capsule)
                .opacity( configuration.isPressed ? 0.5 : 1)
            #else
            if #available(macOS 26.0, iOS 26.0, tvOS 26.0, watchOS 26.0, *){
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
            #endif
        }
        .opacity(isEnabled ? 1 : 0.5)
        .contentShape(Rectangle())
        #endif
            
    }
}

struct SKSecondaryButton: ButtonStyle {
    @Environment(\.accentColor) var accentColor
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.isEnabled) private var isEnabled: Bool
    func makeBody(configuration: Configuration) -> some View {
        #if os(macOS) || os(tvOS)
        configuration.label
            .buttonStyle(.plain)
            .if{ content in
                if #available(macOS 26.0, tvOS 26.0, *){
                    content
                        .frame(minWidth: 105)
                        .fontWeight(.medium)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 11)
                        .glassEffect(.regular.interactive(true))
                        .opacity(configuration.isPressed ? 0.5 : 1)
                        #if os(tvOS)
                        .hoverEffect(.highlight)
                        #endif
                }else{
                    content
                        .padding(.vertical, 1)
                        .padding(.horizontal, 4)
                }
            }
            .opacity(isEnabled ? 1 : 0.5)
            .contentShape(Rectangle())
        #else
        HStack{
            Spacer()
            configuration.label
                .buttonStyle(.plain)
            Spacer()
        }
        .foregroundStyle(accentColor)
        .if{ content in
            #if os(visionOS)
            content
                .fontWeight(.medium)
                .padding(.vertical, 13)
                .background(.clear)
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                .opacity( configuration.isPressed ? 0.5 : 1)
            #else
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
            #endif

        }
        .opacity(isEnabled ? 1 : 0.5)
        .contentShape(Rectangle())
        #endif
    }
}

struct SKNoteButton: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.isEnabled) private var isEnabled: Bool
    @Environment(\.accentColor) private var accentColor: Color
    var textAlignment: TextAlignment
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 3.5){
            if #available(iOS 26.0, tvOS 26.0, macOS 26.0, *){
                Image(systemName: "info.circle.fill")
            }
            configuration.label
                .buttonStyle(.plain)
                .multilineTextAlignment(textAlignment)
                #if os(tvOS)
                .font(.footnote)
                #endif
        }
        .foregroundStyle(accentColor)
        .lineLimit(1)
        .opacity(configuration.isPressed ? 0.5 : 1)
        .contentShape(Rectangle())
        .opacity(isEnabled ? 1 : 0.5)
        #if os(tvOS)
        .hoverEffect(.lift)
        #endif
    }
    
    init(textAlignment: TextAlignment = .leading) {
        self.textAlignment = textAlignment
    }
}

struct SKNavigationButton: ButtonStyle {
    @Environment(\.sheetSize) var sheetSize
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.accentColor) var accentColor
    @Environment(\.isEnabled) private var isEnabled: Bool
    func makeBody(configuration: Configuration) -> some View {
        #if os(macOS) || os(tvOS)
        if sheetSize == .medium{
            configuration.label
                .labelsHidden()
                .buttonStyle(.plain)
                .foregroundStyle(accentColor)
                .if{ content in
                    if #available(macOS 26.0, tvOS 26.0, *){
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
                    if #available(macOS 26.0, tvOS 26.0, *){
                        content
                            .padding(.vertical, 10)
                            .padding(.horizontal, 11)
                            .glassEffect(.regular.interactive(true))
                            .opacity(configuration.isPressed ? 0.5 : 1)
#if os(tvOS)
                            .hoverEffect(.highlight)
#endif
                    }else{
                        content
                            .padding(.vertical, 1)
                            .padding(.horizontal, 4)
                    }
                }
                .contentShape(Rectangle())
                .opacity(isEnabled ? 1 : 0.5)
        }
        #elseif os(visionOS) || os(tvOS)
        configuration.label
            .labelsHidden()
        #else
        configuration.label
            .labelsHidden()
            .foregroundStyle(accentColor)
            .contentShape(Rectangle())
        #endif
    }
}
