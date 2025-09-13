//
//  SKForEach.swift
//  SheetKit
//
//  Created by Kamil Szpak on 21/07/2025.
//

import SwiftUI

public struct SKForEach<Data, ID>: View where Data: RandomAccessCollection, ID: Hashable {
    let data: Data
    let keyPath: KeyPath<Data.Element, ID>
    let content: ((Data.Element) -> [any SKComponent])?
    let pages: ((Data.Element) -> [SKPage])?
    let items: ((Data.Element) -> [SKToolbarItem])?

    public var components: [any SKComponent] {
        data.flatMap { content?($0) ?? [] }
    }
    
    public var pageComponents: [SKPage] {
        data.flatMap { pages?($0) ?? [] }
    }
    
    public var toolbarComponents: [SKToolbarItem] {
        data.flatMap { items?($0) ?? [] }
    }
    
    public var body: some View{
        if !components.isEmpty{
            ForEach(components.indices, id: \.self){index in
                components[index].erasedContent()
            }
        }else if !pageComponents.isEmpty{
            ForEach(pageComponents.indices, id: \.self){index in
                pageComponents[index]
            }
        }else if !toolbarComponents.isEmpty{
            ForEach(toolbarComponents.indices, id: \.self){index in
                toolbarComponents[index]
            }
        }else{
            EmptyView()
        }

    }
    
    // Prefer pages init over content init when both match by disfavoring this overloads
    @_disfavoredOverload
    public init(_ data: Data, id: KeyPath<Data.Element, ID>, @SKPageBuilder content: @escaping (Data.Element) -> [any SKComponent]) {
        self.data = data
        self.keyPath = id
        self.content = content
        self.pages = nil
        self.items = nil
    }
    
    // Prefer pages init over content init when both match by disfavoring this overloads
    @_disfavoredOverload
    public init<T>(_ data: Data, @SKPageBuilder content: @escaping (Data.Element) -> [any SKComponent])
    where Data.Element == T, T: Identifiable, ID == T.ID {
        self.data = data
        self.keyPath = \T.id
        self.content = content
        self.pages = nil
        self.items = nil
    }
    
    public init(_ data: Data, id: KeyPath<Data.Element, ID>, @SKSheetBuilder pages: @escaping (Data.Element) -> [SKPage]) {
        self.data = data
        self.keyPath = id
        self.content = nil
        self.pages = pages
        self.items = nil
    }
    
    public init<T>(_ data: Data, @SKSheetBuilder pages: @escaping (Data.Element) -> [SKPage])
    where Data.Element == T, T: Identifiable, ID == T.ID {
        self.data = data
        self.keyPath = \T.id
        self.content = nil
        self.pages = pages
        self.items = nil
    }
    
    public init(_ data: Data, id: KeyPath<Data.Element, ID>, @SKToolbarBuilder toolbarItems: @escaping (Data.Element) -> [SKToolbarItem]) {
        self.data = data
        self.keyPath = id
        self.content = nil
        self.pages = nil
        self.items = toolbarItems
    }
    
    public init<T>(_ data: Data, @SKToolbarBuilder toolbarItems: @escaping (Data.Element) -> [SKToolbarItem])
    where Data.Element == T, T: Identifiable, ID == T.ID {
        self.data = data
        self.keyPath = \T.id
        self.content = nil
        self.pages = nil
        self.items = toolbarItems
    }
}
