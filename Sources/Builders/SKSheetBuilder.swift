//
//  SKSheetBuilder.swift
//  SheetKit
//
//  Created by Kamil Szpak on 17/08/2025.
//

import SwiftUI

@resultBuilder
public struct SKSheetBuilder {

    /// Handles zero components (empty builder block).
    public static func buildBlock() -> [SKPage] {
        return []
    }

    /// Handles a single SKPage component.
    public static func buildBlock(_ component: SKPage) -> [SKPage] {
        return [component]
    }

    /// Handles multiple SKPage components.
    public static func buildBlock(_ components: SKPage...) -> [SKPage] {
        return components
    }

    /// Handles multiple already-wrapped components (e.g. arrays from conditionals or loops).
    public static func buildBlock(_ components: [SKPage]...) -> [SKPage] {
        return components.flatMap { $0 }
    }

    /// Support for expressions (bare `SKPage` values).
    public static func buildExpression(_ expression: SKPage) -> [SKPage] {
        return [expression]
    }

    /// Support for optional SKPage arrays (e.g. from `if let`).
    public static func buildOptional(_ component: [SKPage]?) -> [SKPage] {
        return component ?? []
    }

    /// Support for `if`/`else` first branch.
    public static func buildEither(first component: [SKPage]) -> [SKPage] {
        return component
    }

    /// Support for `if`/`else` second branch.
    public static func buildEither(second component: [SKPage]) -> [SKPage] {
        return component
    }

    /// Support for loops like `for` that produce `[SKPage]`.
    public static func buildArray(_ components: [[SKPage]]) -> [SKPage] {
        return components.flatMap { $0 }
    }

    /// Support for availability checks.
    public static func buildLimitedAvailability(_ component: [SKPage]) -> [SKPage] {
        return component
    }
    
    public static func buildExpression<Data, ID>(_ forEach: SKForEach<Data, ID, Any>) -> [SKPage] where Data: RandomAccessCollection, ID: Hashable {
        forEach.pageComponents
    }
    public static func buildExpression(_ components: SKPage...) -> [SKPage] {
        return components
    }
}
