//
//  ContrastingTextColor.swift
//  SheetKit
//
//  Created by Kamil Szpak on 11/07/2025.
//

import SwiftUI

// Source: https://dallinjared.medium.com/swiftui-tutorial-contrasting-text-over-background-color-2e7af57c1b20
extension Text {
    func getContrastText(backgroundColor: Color) -> some View {
        var r, g, b, a: CGFloat
        (r, g, b, a) = (0, 0, 0, 0)
        #if !os(macOS)
        UIColor(backgroundColor).getRed(&r, green: &g, blue: &b, alpha: &a)
        #else
        NSColor(backgroundColor).getRed(&r, green: &g, blue: &b, alpha: &a)
        #endif
        let luminance = 0.2126 * r + 0.7152 * g + 0.0722 * b
        return  luminance < 0.6 ? self.foregroundColor(.white) : self.foregroundColor(.black)
    }
}
