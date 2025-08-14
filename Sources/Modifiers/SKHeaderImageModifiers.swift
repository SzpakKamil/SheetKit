//
//  SKHeaderImageModifiers.swift
//  SheetKit
//
//  Created by Kamil Szpak on 08/07/2025.
//

import SwiftUI

public extension SKHeaderImage{
    func skVariant(_ variant: SKHeaderImage.Variant = .none) -> SKHeaderImage{
        var copy = self
        copy.data.variant = variant
        return copy
    }
    func skVerticalPadding(_ padding: SKHeaderImage.VerticalPadding? = nil) -> SKHeaderImage{
        var copy = self
        copy.data.verticalPadding = padding
        return copy
    }
    func skRenderingMode(_ mode: SKRenderingMode = .monochrome) -> SKHeaderImage{
        var copy = self
        copy.data.renderingMode = mode
        return copy
    }
    func skSize(_ size: SKHeaderImage.Size = .medium) -> SKHeaderImage{
        var copy = self
        copy.data.size = size
        return copy
    }
    func skWeight(_ weight: Font.Weight = .regular) -> SKHeaderImage{
        var copy = self
        copy.data.weight = weight
        return copy
    }
}
