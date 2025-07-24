//
//  SKPickerModifiers.swift
//  SheetKit
//
//  Created by Kamil Szpak on 12/07/2025.
//

import SwiftUI

#if !os(watchOS)
public extension SKPicker{
    func backgroundColor(_ color: Color? = nil) -> SKPicker{
        var copy = self
        copy.data.backgroundColor = color
        return copy
    }
    
    #if os(iOS)
    func shape(cornerRadius: CGFloat? = nil) -> SKPicker{
        var copy = self
        copy.data.cornerRadius = cornerRadius
        return copy
    }
    #endif
}
#endif
