//
//  SKHeaderImageModifiers.swift
//  SheetKit
//
//  Created by Kamil Szpak on 08/07/2025.
//

import SwiftUI

public extension SKHeaderImage{
    func tint(_ color: Color = .accentColor) -> SKHeaderImage{
        var copy = self
        copy.data.color = color
        return copy
    }
    func alignment(_ alignment: HorizontalAlignment? = nil) -> SKHeaderImage{
        var copy = self
        copy.data.alignment = alignment
        return copy
    }
    func variant(_ variant: SKHeaderImage.Variant = .none) -> SKHeaderImage{
        var copy = self
        copy.data.variant = variant
        return copy
    }
    func verticalPadding(_ padding: SKHeaderImage.VerticalPadding? = nil) -> SKHeaderImage{
        var copy = self
        copy.data.verticalPadding = padding
        return copy
    }
    func renderingMode(_ mode: SKRenderingMode = .monochrome) -> SKHeaderImage{
        var copy = self
        copy.data.renderingMode = mode
        return copy
    }
    func size(_ size: SKHeaderImage.Size = .medium) -> SKHeaderImage{
        var copy = self
        copy.data.size = size
        return copy
    }
    func weight(_ weight: Font.Weight = .regular) -> SKHeaderImage{
        var copy = self
        copy.data.weight = weight
        return copy
    }
}
