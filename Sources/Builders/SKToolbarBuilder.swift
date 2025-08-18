//
//  SKToolbarBuilder.swift
//  SheetKit
//
//  Created by Kamil Szpak on 17/08/2025.
//

import SwiftUI

@resultBuilder
public struct SKToolbarBuilder {
    public static func buildBlock(_ components: SKToolbarItem...) -> [SKToolbarItem] {
        return components
    }
}
