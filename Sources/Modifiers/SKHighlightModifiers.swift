//
//  SKHighlightModifiers.swift
//  SheetKit
//
//  Created by Kamil Szpak on 09/07/2025.
//

import SwiftUI

public extension SKHighlight{
    func tint(_ color: Color? = nil) -> SKHighlight{
        var copy = self
        copy.data.tintColor = color
        return copy
    }
    func textColor(_ color: Color = .primary) -> SKHighlight{
        var copy = self
        copy.data.textColor = color
        return copy
    }
    func alignment(_ alignment: HorizontalAlignment? = nil) -> SKHighlight{
        var copy = self
        copy.data.alignment = alignment
        return copy
    }
}
