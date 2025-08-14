//
//  SKPageModifiers.swift
//  SheetKit
//
//  Created by Kamil Szpak on 14/07/2025.
//

import SwiftUI

public extension SKPageable{
    func skAccentColor(_ color: Color = .accentColor) -> SKCustomPage{
        return SKCustomPage(data: data) {
            self.environment(\.skAccentColor, color)
        }
    }
    func skAlignment(_ alignment: HorizontalAlignment?) -> SKCustomPage{
        return SKCustomPage(data: data) {
            self.environment(\.skAlignment, alignment)
        }
    }
    func skRowBackground(_ color: Color? = nil) -> SKCustomPage{
        return SKCustomPage(data: data) {
            self.environment(\.skRowBackgroundColor, color)
        }
    }
    func skRowSpacing(_ spacing: CGFloat? = nil) -> SKCustomPage{
        return SKCustomPage(data: data) {
            self.environment(\.skRowSpacing, spacing)
        }
    }
    func skRowShape(cornerRadius: CGFloat? = nil) -> SKCustomPage{
        return SKCustomPage(data: data) {
            self.environment(\.skRowShape, cornerRadius)
        }
    }
    func skPrimaryTextColor(_ color: Color? = nil) -> SKCustomPage{
        return SKCustomPage(data: data) {
            self.environment(\.skPrimaryColor, color)
        }
    }
    func skSecondaryTextColor(_ color: Color? = nil) -> SKCustomPage{
        return SKCustomPage(data: data) {
            self.environment(\.skSecondaryColor, color)
        }
    }
    func skHideCloseButton(_ configuration: Bool = true) -> SKCustomPage{
        return SKCustomPage(data: data) {
            self.environment(\.skIsCloseButtonHidden, configuration)
        }
    }
}

public extension SKPage{
    
    func skAlert(isPresented: Binding<Bool>, title: String, description: String, type: AlertType? = nil, @ViewBuilder content: @escaping () -> some View) -> SKPage{
        var copy = self
        copy.data.alert = .init(isPresented: isPresented, title: title, description: description, type: type, content: content)
        return copy
    }
    
    func skAlert(title: String, description: String, type: AlertType, condition: Bool = true, @ViewBuilder content: @escaping () -> some View) -> SKPage{
        var copy = self
        copy.data.alert = .init(isPresented: Binding(get: { condition }, set: { _ in }), title: title, description: description, type: type, content: content)
        return copy
    }
    func skStyle(_ style: SKPage.BackgroundStyle? = nil) -> SKPage{
        var copy = self
        copy.data.backgroundStyle = style
        return copy
    }
    func skHideCloseButton(_ configuration: Bool = true) -> SKPage{
        var copy = self
        copy.data.hideCloseButton = configuration
        return copy
    }
}
