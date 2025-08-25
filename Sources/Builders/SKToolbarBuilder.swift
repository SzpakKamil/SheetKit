//
//  SKToolbarBuilder.swift
//  SheetKit
//
//  Created by Kamil Szpak on 17/08/2025.
//

import SwiftUI

@resultBuilder
public struct SKToolbarBuilder {
    public static func buildBlock() -> [SKToolbarItem] {
        []
    }
    
    public static func buildBlock(_ components: SKToolbarItem...) -> [SKToolbarItem] {
        components
    }
    
    public static func buildBlock(_ components: [SKToolbarItem]) -> [SKToolbarItem]{
        components
    }
    public static func buildBlock(_ components: [SKToolbarItem]...) -> [SKToolbarItem] {
        components.flatMap{ $0 }
    }
    public static func buildOptional(_ component: [SKToolbarItem]?) -> [SKToolbarItem] {
        component ?? []
    }
    public static func buildEither(first component: [SKToolbarItem]) -> [SKToolbarItem] {
        component
    }
    public static func buildEither(second component: [SKToolbarItem]) -> [SKToolbarItem] {
        component
    }
    public static func buildLimitedAvailability(_ component: [SKToolbarItem]) -> [SKToolbarItem] {
        component
    }
    @_documentation(visibility: internal)
    public static func buildExpression<Data, ID>(_ forEach: SKForEach<Data, ID>) -> [SKToolbarItem] where Data: RandomAccessCollection, ID: Hashable {
        forEach.toolbarComponents
    }
    public static func buildExpression(_ components: SKToolbarItem...) -> [SKToolbarItem] {
        return components
    }
}
