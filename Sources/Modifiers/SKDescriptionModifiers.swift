//
//  SKTitleModifiers.swift
//  SheetKit
//
//  Created by Kamil Szpak on 09/07/2025.
//

import SwiftUI

public extension SKDescription{
    func weight(_ weight: Font.Weight = .regular) -> SKDescription{
        var copy = self
        copy.data.weight = weight
        return copy
    }
    func font(_ font: Font? = nil) -> SKDescription{
        var copy = self
        copy.data.font = font
        return copy
    }
    func tint(_ color: Color? = nil) -> SKDescription{
        var copy = self
        copy.data.color = color
        return copy
    }
    func alignment(_ alignment: TextAlignment? = nil) -> SKDescription{
        var copy = self
        copy.data.alignment = alignment
        return copy
    }
}
