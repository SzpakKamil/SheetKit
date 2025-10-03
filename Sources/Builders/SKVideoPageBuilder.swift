//
//  SKVideoPageBuilder.swift
//  SheetKit
//
//  Created by Kamil Szpak on 17/08/2025.
//

import SwiftUI

#if os(iOS)
@resultBuilder
public struct SKVideoPageBuilder {
    public static func buildBlock() -> [SKVideoHighlight] {
        []
    }
    
    public static func buildBlock(_ components: SKVideoHighlight...) -> [SKVideoHighlight] {
        components
    }
    
    public static func buildBlock(_ components: [SKVideoHighlight]) -> [SKVideoHighlight] {
        components
    }
    
    public static func buildBlock(_ components: [SKVideoHighlight]...) -> [SKVideoHighlight] {
        components.flatMap { $0 }
    }
    
    public static func buildOptional(_ component: [SKVideoHighlight]?) -> [SKVideoHighlight] {
        component ?? []
    }
    
    public static func buildEither(first component: [SKVideoHighlight]) -> [SKVideoHighlight] {
        component
    }
    
    public static func buildEither(second component: [SKVideoHighlight]) -> [SKVideoHighlight] {
        component
    }
    
    public static func buildLimitedAvailability(_ component: [SKVideoHighlight]) -> [SKVideoHighlight] {
        component
    }
    
    public static func buildExpression(_ components: SKVideoHighlight...) -> [SKVideoHighlight] {
        return components
    }
}
#endif
