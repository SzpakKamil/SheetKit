//
//  SKButtonStylesIOS.swift
//  SheetKit
//
//  Created by Kamil Szpak on 26/07/2025.
//

#if os(iOS)
import SwiftUI

struct SKPrimaryButtonStyleIOS: ButtonStyle {
    let isEnabled: Bool
    let accentColor: Color
    func makeBody(configuration: Configuration) -> some View {
        HStack{
            Spacer()
            configuration.label
                .buttonStyle(.plain)
            Spacer()
        }
        .foregroundStyle(.white)
        .if{ content in
            if #available(iOS 26.0, *){
                content
                    .fontWeight(.medium)
                    .padding(.vertical, 17)
                    #if compiler(>=6.2)
                    .glassEffect(.regular.tint(accentColor).interactive(true))
                    #endif
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
    
    init(isEnabled: Bool, accentColor: Color) {
        self.isEnabled = isEnabled
        self.accentColor = accentColor
    }
}

struct SKSecondaryButtonStyleIOS: ButtonStyle {
    let isEnabled: Bool
    let accentColor: Color
    func makeBody(configuration: Configuration) -> some View {
        HStack{
            Spacer()
            configuration.label
                .buttonStyle(.plain)
            Spacer()
        }
        .foregroundStyle(accentColor)
        .if{ content in
            if #available(iOS 26.0, *){
                content
                    .fontWeight(.medium)
                    .padding(.vertical, 17)
                    #if compiler(>=6.2)
                    .glassEffect(.regular.interactive(true))
                    #endif
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
    
    init(isEnabled: Bool, accentColor: Color) {
        self.isEnabled = isEnabled
        self.accentColor = accentColor
    }
}

struct SKNoteButtonStyleIOS: ButtonStyle {
    let colorScheme: ColorScheme
    let isEnabled: Bool
    let accentColor: Color
    var textAlignment: TextAlignment
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 3.5){
            if #available(iOS 26.0, *){
                Image(systemName: "info.circle.fill")
            }
            configuration.label
                .buttonStyle(.plain)
                .multilineTextAlignment(textAlignment)
        }
        .padding(.top, 5)
        .foregroundStyle(accentColor)
        .lineLimit(1)
        .opacity(configuration.isPressed ? 0.5 : 1)
        .contentShape(Rectangle())
        .opacity(isEnabled ? 1 : 0.5)
    }
    
    init(colorScheme: ColorScheme, isEnabled: Bool, accentColor: Color, textAlignment: TextAlignment = .leading) {
        self.colorScheme = colorScheme
        self.isEnabled = isEnabled
        self.accentColor = accentColor
        self.textAlignment = textAlignment
    }
}

struct SKNavigationButtonStyleIOS: ButtonStyle {
    let sheetStyle: SKSheetStyle?
    let colorScheme: ColorScheme
    let isEnabled: Bool
    let accentColor: Color
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .labelsHidden()
            .buttonStyle(.plain)
            .foregroundStyle(accentColor)
            .contentShape(Rectangle())
    }
    init(sheetStyle: SKSheetStyle?, colorScheme: ColorScheme, isEnabled: Bool, accentColor: Color) {
        self.sheetStyle = sheetStyle
        self.colorScheme = colorScheme
        self.isEnabled = isEnabled
        self.accentColor = accentColor
    }
}

#if DEBUG
#Preview{
    PreviewViewSKButton()
}
#endif
#endif
