//
//  SKSheetModifiers.swift
//  SheetKit
//
//  Created by Kamil Szpak on 14/07/2025.
//

import SwiftUI

public extension SKSheet{
    func interactiveDismissDisabled(_ disabled: Bool = true) -> SKSheet{
        var copy = self
        copy.data.allowsInteractiveDismissal = !disabled
        return copy
    }
    #if !os(macOS)
    func presentationDents(_ dents: Set<PresentationDetent>) -> SKSheet{
        var copy = self
        copy.data.presentationDents = dents
        copy.selectedPresentationDent = .constant(dents.first ?? .large)
        return copy
    }
    func dragIndicatorVisibility(_ visibility: Visibility = .hidden) -> SKSheet{
        var copy = self
        copy.data.dragIndicatorVisibility = visibility
        return copy
    }
    func presentationDents(_ dents: Set<PresentationDetent>, selection: Binding<PresentationDetent>) -> SKSheet{
        var copy = self
        copy.data.presentationDents = dents
        copy.selectedPresentationDent = selection
        return copy
    }
    #else
    func sheetSize(_ sheetSize: SKSheetSize? = nil) -> SKSheet{
        var copy = self
        copy.data.sheetSize = sheetSize
        return copy
    }
    #endif
    func tint(_ color: Color) -> SKSheet{
        var copy = self
        copy.data.accentColor = color
        return copy
    }
    func alignment(_ alignment: HorizontalAlignment? = nil) -> SKSheet{
        var copy = self
        copy.data.alignment = alignment
        return copy
    }
}
