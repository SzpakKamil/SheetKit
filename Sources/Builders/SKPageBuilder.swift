//
//  SKPageBuilder.swift
//  SheetKit
//
//  Created by Kamil Szpak on 17/08/2025.
//

import SwiftUI

@resultBuilder
public struct SKPageBuilder {
    public static func buildBlock(_ components: any SKComponent...) -> [any SKComponent] {
        components
    }
    
    public static func buildBlock() -> [any SKComponent] {
        []
    }
    
    public static func buildArray(_ components: [[any SKComponent]]) -> [any SKComponent] {
        components.flatMap { $0 }
    }
    
    public static func buildOptional(_ component: [any SKComponent]?) -> [any SKComponent] {
        component ?? []
    }
    
    public static func buildEither(first component: [any SKComponent]) -> [any SKComponent] {
        component
    }
    
    public static func buildEither(second component: [any SKComponent]) -> [any SKComponent] {
        component
    }
    
    public static func buildBlock(_ components: [any SKComponent]...) -> [any SKComponent] {
        components.flatMap{ $0 }
    }
    
    public static func buildLimitedAvailability(_ component: [any SKComponent]) -> [any SKComponent] {
        component
    }
    public static func buildExpression<Data, ID>(_ forEach: SKForEach<Data, ID, Any>) -> [any SKComponent] where Data: RandomAccessCollection, ID: Hashable {
        forEach.components
    }
    public static func buildExpression(_ components: any SKComponent...) -> [any SKComponent] {
        return components
    }
}
