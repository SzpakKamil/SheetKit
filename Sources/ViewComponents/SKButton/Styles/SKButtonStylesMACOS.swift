//
//  SKButtonStylesMACOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 26/07/2025.
//
#if os(macOS)
import SwiftUI

struct SKPrimaryButtonStyleMACOS: ButtonStyle {
    let sheetStyle: SKSheetStyle?
    let isEnabled: Bool
    let accentColor: Color
    let colorScheme: ColorScheme
    func makeBody(configuration: Configuration) -> some View {
        let accentColor: Color = (isEnabled ? accentColor : .gray)
        configuration.label
            .buttonStyle(.plain)
            .if{ content in
                if #available(macOS 26.0, *){
                    content
                        .frame(minWidth: sheetStyle == .prominent ? 125 : 105)
                        .foregroundStyle(.white)
                        .padding(.vertical, sheetStyle == .prominent ? 5 : 10)
                        .padding(.horizontal, sheetStyle == .prominent ? 11 : 11)
                        #if compiler(>=6.2)
                        .glassEffect(.regular.tint(accentColor).interactive(true))
                        #endif
                        .opacity(configuration.isPressed ? 0.5 : 1)
                }else{
                    content
                        .frame(minWidth: 50)
                        .foregroundStyle(.white)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 11)
                        .background(LinearGradient(stops: colorScheme == .dark ? [
                            .init(color: accentColor, location: 0),
                            .init(color: accentColor.opacity(0.8), location: 1)
                        ] : [
                            .init(color: accentColor.opacity(0.8), location: 0),
                            .init(color: accentColor, location: 1)
                        ], startPoint: .top, endPoint: .bottom) )
                        .clipShape(RoundedRectangle(cornerRadius: 6, style: .circular))
                        .overlay(
                            RoundedRectangle(cornerRadius: 6, style: .circular)
                                .stroke(.primary.opacity(0.06), lineWidth: 1)
                        )
                        .opacity(configuration.isPressed ? 0.5 : 1)
                        .shadow(color: accentColor.opacity(0.25), radius: 1, y: 0.5)
                }
            }
            .opacity(isEnabled ? 1 : 0.5)
            .contentShape(Rectangle())
    }
    
    init(isEnabled: Bool, accentColor: Color, sheetStyle: SKSheetStyle?, colorScheme: ColorScheme) {
        self.isEnabled = isEnabled
        self.sheetStyle = sheetStyle
        self.accentColor = accentColor
        self.colorScheme = colorScheme
    }
}

struct SKSecondaryButtonStyleMACOS: ButtonStyle {
    let sheetStyle: SKSheetStyle?
    let isEnabled: Bool
    let accentColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .buttonStyle(.plain)
            .if{ content in
                if #available(macOS 26.0, *){
                    content
                        .frame(minWidth: sheetStyle == .prominent ? 125 : 105)
                        .padding(.vertical, sheetStyle == .prominent ? 6 : 10)
                        .padding(.horizontal, sheetStyle == .prominent ? 11 : 11)
                        #if compiler(>=6.2)
                        .glassEffect(.regular.interactive(true))
                        #endif
                        .opacity(configuration.isPressed ? 0.5 : 1)
                }else{
                    content
                        .padding(.vertical, 6)
                        .padding(.horizontal, 11)
                        .foregroundStyle(accentColor)
                        .lineLimit(1)
                        .opacity(configuration.isPressed ? 0.5 : 1)
                        .contentShape(Rectangle())
                        .opacity(isEnabled ? 1 : 0.5)
                }
            }
            .opacity(isEnabled ? 1 : 0.5)
            .contentShape(Rectangle())
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
    
    init(isEnabled: Bool, accentColor: Color, colorScheme: ColorScheme, textAlignment: TextAlignment) {
        self.isEnabled = isEnabled
        self.accentColor = accentColor
        self.colorScheme = colorScheme
        self.textAlignment = textAlignment
    }
}

struct SKNavigationButtonStyleMACOS: ButtonStyle{
    let sheetStyle: SKSheetStyle?
    let isEnabled: Bool
    let accentColor: Color
    let colorScheme: ColorScheme
    
    var invertedPrimary: Color{
        if colorScheme == .dark{
            return .white
        }else{
            return .black
        }
    }
    func makeBody(configuration: Configuration) -> some View {
        if #available(macOS 26.0, *){
            if sheetStyle != .default{
                configuration.label
                    .labelsHidden()
                    .buttonStyle(.plain)
                    .foregroundStyle(accentColor)
                    .padding(.vertical, 13)
                    .padding(.horizontal, 13)
                    #if compiler(>=6.2)
                    .glassEffect(.regular.interactive(true), in: .circle)
                    #endif
                    .opacity(configuration.isPressed ? 0.5 : 1)
                    .contentShape(Rectangle())
                    .opacity(isEnabled ? 1 : 0.5)
            }else{
                configuration.label
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                    .buttonStyle(.plain)
                    .frame(minWidth: 105)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 11)
                    #if compiler(>=6.2)
                    .glassEffect(.regular.interactive(true))
                    #endif
                    .opacity(configuration.isPressed ? 0.5 : 1)
                    .contentShape(Rectangle())
                    .opacity(isEnabled ? 1 : 0.5)
            }
        }else{
            configuration.label
                .foregroundStyle(colorScheme == .dark ? .white : .black)
                .buttonStyle(.plain)
                .frame(minWidth: 50)
                .padding(.vertical, 6)
                .padding(.horizontal, 11)
                .if{ content in
                    if colorScheme == .dark{
                        content
                            .background(LinearGradient(stops: [
                                .init(color: .white.opacity(0.4), location: 0),
                                .init(color: .white.opacity(0.3), location: 1)
                            ], startPoint: .top, endPoint: .bottom) )
                    }else{
                        content
                            .background(.background)
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 6, style: .circular))
                .overlay(
                    RoundedRectangle(cornerRadius: 6, style: .circular)
                        .stroke(.primary.opacity(0.06), lineWidth: 1)
                )
                .opacity(configuration.isPressed ? 0.5 : 1)
                .shadow(color: invertedPrimary.opacity(0.25), radius: 1, y: 0.5)
                .contentShape(Rectangle())
                .opacity(isEnabled ? 1 : 0.5)
        }
    }
    
    init(sheetStyle: SKSheetStyle?, isEnabled: Bool, accentColor: Color, colorScheme: ColorScheme) {
        self.sheetStyle = sheetStyle
        self.isEnabled = isEnabled
        self.accentColor = accentColor
        self.colorScheme = colorScheme
    }
}

#endif

