//
//  SKButtonStylesTVOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 26/07/2025.
//

#if os(tvOS)
import SwiftUI

struct SKPrimaryButtonStyleTVOS: ButtonStyle {
    let isEnabled: Bool
    let accentColor: Color
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .buttonStyle(.plain)
            .frame(minWidth: 105)
            .if{ content in
                if #available(tvOS 26.0, *){
                    content
                        .fontWeight(.medium)
                        .foregroundStyle(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 11)
                        #if compiler(>=6.2)
                        .glassEffect(.regular.tint(accentColor).interactive(true), in: .rect)
                        #endif
                        .opacity(configuration.isPressed ? 0.5 : 1)
                        .hoverEffect(.highlight)
                }else{
                    content
                        .fontWeight(.medium)
                        .foregroundStyle(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 11)
                        .background(accentColor)
                        .opacity(configuration.isPressed ? 0.5 : 1)
                        .hoverEffect(.highlight)
                }
            }
            .opacity(isEnabled ? 1 : 0.5)
            .contentShape(Rectangle())
    }
    
    init(isEnabled: Bool, accentColor: Color) {
        self.isEnabled = isEnabled
        self.accentColor = accentColor
    }
}

struct SKSecondaryButtonStyleTVOS: ButtonStyle {
    let isEnabled: Bool
    let accentColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .buttonStyle(.plain)
            .if{ content in
                if #available(tvOS 26.0, *){
                    content
                        .frame(minWidth: 105)
                        .fontWeight(.medium)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 11)
                        #if compiler(>=6.2)
                        .glassEffect(.regular.interactive(true))
                        #endif
                        .opacity(configuration.isPressed ? 0.5 : 1)
                        .hoverEffect(.highlight)
                }else{
                    content
                        .fontWeight(.medium)
                        .foregroundStyle(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 11)
                        .background(.regularMaterial)
                        .opacity(configuration.isPressed ? 0.5 : 1)
                        .hoverEffect(.highlight)
                }
            }
            .opacity(isEnabled ? 1 : 0.5)
            .contentShape(Rectangle())
    }
    
    init(isEnabled: Bool, accentColor: Color) {
        self.isEnabled = isEnabled
        self.accentColor = accentColor
    }
}

struct SKNoteButtonStyleTVOS: ButtonStyle {
    let isEnabled: Bool
    let accentColor: Color
    let colorScheme: ColorScheme
    var textAlignment: TextAlignment
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 3.5){
            if #available(macOS 26.0, *){
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
        .hoverEffect(.lift)
    }
    
    init(isEnabled: Bool, accentColor: Color, colorScheme: ColorScheme, textAlignment: TextAlignment = .leading) {
        self.isEnabled = isEnabled
        self.accentColor = accentColor
        self.colorScheme = colorScheme
        self.textAlignment = textAlignment
    }
}

struct SKNoteButtonStyleMACOS: ButtonStyle {
    let isEnabled: Bool
    let accentColor: Color
    let colorScheme: ColorScheme
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
    
    init(isEnabled: Bool, accentColor: Color, colorScheme: ColorScheme, textAlignment: TextAlignment = .leading) {
        self.isEnabled = isEnabled
        self.accentColor = accentColor
        self.colorScheme = colorScheme
        self.textAlignment = textAlignment
    }
}

struct SKNavigationButtonStyleTVOS: ButtonStyle {
    let sheetSize: SKSheetSize?
    let isEnabled: Bool
    let accentColor: Color
    func makeBody(configuration: Configuration) -> some View {
        if sheetSize == .medium{
            configuration.label
                .labelsHidden()
                .buttonStyle(.plain)
                .foregroundStyle(accentColor)
                .if{ content in
                    if #available(tvOS 26.0, *){
                        content
                            .padding(.vertical, 13)
                            .padding(.horizontal, 13)
                            #if compiler(>=6.2)
                            .glassEffect(.regular.interactive(true), in: .circle)
                            #endif
                            .opacity(configuration.isPressed ? 0.5 : 1)
                    }else{
                        content
                            .fontWeight(.medium)
                            .foregroundStyle(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 11)
                            .background(.regularMaterial)
                            .opacity(configuration.isPressed ? 0.5 : 1)
                            .hoverEffect(.highlight)
                    }
                }
                .contentShape(Rectangle())
                .opacity(isEnabled ? 1 : 0.5)
        }else{
            configuration.label
                .buttonStyle(.plain)
                .frame(minWidth: 105)
                .if{ content in
                    if #available(tvOS 26.0, *){
                        content
                            .padding(.vertical, 10)
                            .padding(.horizontal, 11)
                            #if compiler(>=6.2)
                            .glassEffect(.regular.interactive(true))
                            #endif
                            .opacity(configuration.isPressed ? 0.5 : 1)
                            .hoverEffect(.highlight)
                    }else{
                        content
                            .fontWeight(.medium)
                            .foregroundStyle(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 11)
                            .background(.regularMaterial)
                            .opacity(configuration.isPressed ? 0.5 : 1)
                            .hoverEffect(.highlight)
                    }
                }
                .contentShape(Rectangle())
                .opacity(isEnabled ? 1 : 0.5)
        }
    }
    
    init(sheetSize: SKSheetSize?, isEnabled: Bool, accentColor: Color) {
        self.sheetSize = sheetSize
        self.isEnabled = isEnabled
        self.accentColor = accentColor
    }
}

#if DEBUG
#Preview{
    SKButtonStylesPreviewContent()
}
#endif
#endif
