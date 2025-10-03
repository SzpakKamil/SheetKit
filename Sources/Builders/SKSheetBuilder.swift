//
//  SKSheetBuilder.swift
//  SheetKit
//
//  Created by Kamil Szpak on 17/08/2025.
//

import SwiftUI

@resultBuilder
public struct SKSheetBuilder {
    public static func buildBlock() -> [any SKPageable] {
        []
    }
    
    public static func buildBlock(_ components: any SKPageable...) -> [any SKPageable] {
        components
    }
    
    public static func buildBlock(_ components: [any SKPageable]) -> [any SKPageable]{
        components
    }
    public static func buildBlock(_ components: [any SKPageable]...) -> [any SKPageable] {
        components.flatMap{ $0 }
    }
    public static func buildOptional(_ component: [any SKPageable]?) -> [any SKPageable] {
        component ?? []
    }
    public static func buildEither(first component: [any SKPageable]) -> [any SKPageable] {
        component
    }
    public static func buildEither(second component: [any SKPageable]) -> [any SKPageable] {
        component
    }
    public static func buildLimitedAvailability(_ component: [any SKPageable]) -> [any SKPageable] {
        component
    }
    @_documentation(visibility: internal)
    public static func buildExpression<Data, ID>(_ forEach: SKForEach<Data, ID>) -> [any SKPageable] where Data: RandomAccessCollection, ID: Hashable{
        forEach.pageComponents
    }
    public static func buildExpression(_ components: any SKPageable...) -> [any SKPageable] {
        return components
    }
}
