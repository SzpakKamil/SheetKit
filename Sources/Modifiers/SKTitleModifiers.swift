//
//  SKTitleModifiers.swift
//  SheetKit
//
//  Created by Kamil Szpak on 09/07/2025.
//

import SwiftUI

public extension SKTitle{
    func skFontWeight(_ weight: Font.Weight = .regular) -> SKTitle{
        var copy = self
        copy.data.weight = weight
        return copy
    }
    func skFont(_ font: Font? = nil) -> SKTitle{
        var copy = self
        copy.data.font = font
        return copy
    }
}
