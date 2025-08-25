//
//  SKSheetBuilder.swift
//  SheetKit
//
//  Created by Kamil Szpak on 17/08/2025.
//

import SwiftUI

@resultBuilder
public struct SKSheetBuilder {
    public static func buildBlock() -> [SKPage] {
        []
    }
    
    public static func buildBlock(_ components: SKPage...) -> [SKPage] {
        components
    }
    
    public static func buildBlock(_ components: [SKPage]) -> [SKPage]{
        components
    }
    public static func buildBlock(_ components: [SKPage]...) -> [SKPage] {
        components.flatMap{ $0 }
    }
    public static func buildOptional(_ component: [SKPage]?) -> [SKPage] {
        component ?? []
    }
    public static func buildEither(first component: [SKPage]) -> [SKPage] {
        component
    }
    public static func buildEither(second component: [SKPage]) -> [SKPage] {
        component
    }
    public static func buildLimitedAvailability(_ component: [SKPage]) -> [SKPage] {
        component
    }
    @_documentation(visibility: internal)
    public static func buildExpression<Data, ID>(_ forEach: SKForEach<Data, ID>) -> [SKPage] where Data: RandomAccessCollection, ID: Hashable{
        forEach.pageComponents
    }
    public static func buildExpression(_ components: SKPage...) -> [SKPage] {
        return components
    }
}
