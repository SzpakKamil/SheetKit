//
//  SKTitleModifiers.swift
//  SheetKit
//
//  Created by Kamil Szpak on 09/07/2025.
//

import SwiftUI

public extension SKDescription{
    func skFontWeight(_ weight: Font.Weight = .regular) -> SKDescription{
        var copy = self
        copy.data.weight = weight
        return copy
    }
    func skFont(_ font: Font? = nil) -> SKDescription{
        var copy = self
        copy.data.font = font
        return copy
    }
}
