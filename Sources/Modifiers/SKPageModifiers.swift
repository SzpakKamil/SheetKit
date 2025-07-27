//
//  SKPageModifiers.swift
//  SheetKit
//
//  Created by Kamil Szpak on 14/07/2025.
//

import SwiftUI

public extension SKPage{
    func alert(isPresented: Binding<Bool>, title: String, description: String, type: AlertType = .manual, @ViewBuilder content: @escaping () -> some View) -> SKPage{
        var copy = self
        copy.data.alert = .init(isPresented: isPresented, title: title, description: description, type: type, content: content)
        return copy
    }
    func style(_ style: SKPage.BackgroundStyle? = nil) -> SKPage{
        var copy = self
        copy.data.backgroundStyle = style
        return copy
    }
    func tint(_ color: Color) -> SKPage{
        var copy = self
        copy.data.accentColor = color
        return copy
    }
    
    func alignment(_ alignment: HorizontalAlignment? = nil) -> SKPage{
        var copy = self
        copy.data.alignment = alignment
        return copy
    }
}
