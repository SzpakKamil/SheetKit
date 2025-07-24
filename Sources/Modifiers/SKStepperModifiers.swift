//
//  SKStepperModifiers.swift
//  SheetKit
//
//  Created by Kamil Szpak on 12/07/2025.
//

import SwiftUI

#if !os(tvOS)
public extension SKStepper{
    #if !os(macOS)
    func backgroundColor(_ color: Color? = nil) -> SKStepper{
        var copy = self
        copy.data.backgroundColor = color
        return copy
    }
    #endif
    
    #if os(iOS)
    func shape(cornerRadius: CGFloat? = nil) -> SKStepper{
        var copy = self
        copy.data.cornerRadius = cornerRadius
        return copy
    }
    #endif
}
#endif
