//
//  SKRenderingMode.swift.swift
//  SheetKit
//
//  Created by Kamil Szpak on 08/07/2025.
//

import Foundation
import SwiftUI

public enum SKRenderingMode{
    case monochrome
    case hierarchical
    
    @available(iOS 15.0, macOS 12.0, *)
    func getSymbolRenderingMode() -> SymbolRenderingMode{
        switch self {
        case .monochrome:
                .monochrome
        case .hierarchical:
                .hierarchical
        }
    }
}
