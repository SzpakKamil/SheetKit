//
//  SKPageModifiers.swift
//  SheetKit
//
//  Created by Kamil Szpak on 14/07/2025.
//

import SwiftUI

public extension SKPageable{
    func skAlert(isPresented: Binding<Bool>, title: String, description: String, type: SKAlert.AlertType? = nil, @ViewBuilder content: @escaping () -> some View) -> SKPageable{
        var copy = self
        copy.data.alert = .init(isPresented: isPresented, title: title, description: description, type: type, content: content)
        return copy
    }
    
    func skAlert(title: String, description: String, type: SKAlert.AlertType, condition: Bool = true, @ViewBuilder content: @escaping () -> some View) -> SKPageable{
        var copy = self
        copy.data.alert = .init(isPresented: Binding(get: { condition }, set: { _ in }), title: title, description: description, type: type, content: content)
        return copy
    }
    
    func skPageBackground(_ style: SKPageBackgroundStyle? = nil) -> SKPageable{
        var copy = self
        copy.data.backgroundStyle = style
        return copy
    }
    func skPageBackground(@ViewBuilder _ content: () -> some View) -> SKPageable{
        var copy = self
        copy.data.backgroundStyle = .init(content: content)
        return copy
    }
    func skPageBackground(@ViewBuilder light: () -> some View, @ViewBuilder dark: () -> some View) -> SKPageable{
        var copy = self
        copy.data.backgroundStyle = .init(lightView: light, darkView: dark)
        return copy
    }
    func skPageStyle(_ style: SKPageStyle = .default) -> SKPageable{
        var copy = self
        copy.data.pageStyle = style
        return copy
    }

    func skAccentColor(_ color: Color = .accentColor) -> SKPageable{
        return SKPage(data: data) {
            self.environment(\.skAccentColor, color)
        }
    }
    func skAlignment(_ alignment: HorizontalAlignment?) -> SKPageable{
        return SKPage(data: data) {
            self.environment(\.skAlignment, alignment)
        }
    }
    func skRowBackground(_ color: Color? = nil) -> SKPageable{
        return SKPage(data: data) {
            self.environment(\.skRowBackgroundColor, color)
        }
    }
    func skRowSpacing(_ spacing: CGFloat? = nil) -> SKPageable{
        return SKPage(data: data) {
            self.environment(\.skRowSpacing, spacing)
        }
    }
    func skRowShape(cornerRadius: CGFloat? = nil) -> SKPageable{
        return SKPage(data: data) {
            self.environment(\.skRowShape, cornerRadius)
        }
    }
    func skPrimaryTextColor(_ color: Color? = nil) -> SKPageable{
        return SKPage(data: data) {
            self.environment(\.skPrimaryColor, color)
        }
    }
    func skSecondaryTextColor(_ color: Color? = nil) -> SKPageable{
        return SKPage(data: data) {
            self.environment(\.skSecondaryColor, color)
        }
    }
    func skHideCloseButton(_ configuration: Bool = true) -> SKPageable{
        return SKPage(data: data) {
            self.environment(\.skIsCloseButtonHidden, configuration)
        }
    }
    func skHideBackButton(_ configuration: Bool = true) -> SKPageable{
        return SKPage(data: data) {
            self.environment(\.skIsBackButtonHidden, configuration)
        }
    }
    func skHideContinueButton(_ configuration: Bool = true) -> SKPageable{
        return SKPage(data: data) {
            self.environment(\.skIsContinueButtonHidden, configuration)
        }
    }
}

#if !os(watchOS)
public extension SKVideoPage{
    func skHideSkipButton(_ configuration: Bool = true) -> SKPageable{
        return SKPage(data: data) {
            self.environment(\.skIsSkipButtonHidden, configuration)
        }
    }
}
#endif
