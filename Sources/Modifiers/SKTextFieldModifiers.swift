//
//  SKTextFieldModifiers.swift
//  SheetKit
//
//  Created by Kamil Szpak on 12/07/2025.
//

import SwiftUI

public extension SKTextField{
    func backgroundColor(_ color: Color? = nil) -> SKTextField{
        var copy = self
        copy.data.backgroundColor = color
        return copy
    }
    func shape(cornerRadius: CGFloat? = nil) -> SKTextField{
        var copy = self
        copy.data.cornerRadius = cornerRadius
        return copy
    }
}
