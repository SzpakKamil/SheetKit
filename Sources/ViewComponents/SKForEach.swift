//
//  SKForEach.swift
//  SheetKit
//
//  Created by Kamil Szpak on 21/07/2025.
//

import SwiftUI

public struct SKForEach<Data, ID, Content>: SKComponent where Data: RandomAccessCollection, Content: SKComponent, ID: Hashable {
    public let type: SKComponentType = .forEach
    let data: Data
    let keyPath: KeyPath<Data.Element, ID>
    let content: (Data.Element) -> Content

    public init(_ data: Data, id: KeyPath<Data.Element, ID>, @ViewBuilder content: @escaping (Data.Element) -> Content) {
        self.data = data
        self.keyPath = id
        self.content = content
    }
    public init<T>(_ data: Data, @ViewBuilder content: @escaping (Data.Element) -> Content)
    where Data.Element == T, T: Identifiable, ID == T.ID {
        self.data = data
        self.keyPath = \T.id
        self.content = content
    }

    public var body: some View {
        ForEach(data, id: keyPath) { item in
            content(item)
        }
    }
}
