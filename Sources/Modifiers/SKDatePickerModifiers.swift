//
//  SKDatePicker.swift
//  SheetKit
//
//  Created by Kamil Szpak on 12/07/2025.
//

import SwiftUI

public extension SKDatePicker{
    #if !os(macOS)
    func backgroundColor(_ color: Color? = nil) -> SKDatePicker{
        var copy = self
        copy.data.backgroundColor = color
        return copy
    }
    #endif
    
    #if os(iOS)
    func shape(cornerRadius: CGFloat? = nil) -> SKDatePicker{
        var copy = self
        copy.data.cornerRadius = cornerRadius
        return copy
    }
#endif
}
