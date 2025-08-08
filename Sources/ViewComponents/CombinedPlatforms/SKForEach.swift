//
//  SKForEach.swift
//  SheetKit
//
//  Created by Kamil Szpak on 21/07/2025.
//

import SwiftUI

public struct SKForEach<Data, ID, Content>: View where Data: RandomAccessCollection, ID: Hashable {
    let data: Data
    let keyPath: KeyPath<Data.Element, ID>
    let content: (Data.Element) -> [any SKComponent]

    public var components: [any SKComponent] {
        data.flatMap { content($0) }
    }
    
    public var body: some View{
        ForEach(components.indices, id: \.self){index in
            components[index].erasedContent()
        }
    }
    
    public init(_ data: Data, id: KeyPath<Data.Element, ID>, @SKPageBuilder content: @escaping (Data.Element) -> [any SKComponent]) {
        self.data = data
        self.keyPath = id
        self.content = content
    }
    
    public init<T>(_ data: Data, @SKPageBuilder content: @escaping (Data.Element) -> [any SKComponent])
    where Data.Element == T, T: Identifiable, ID == T.ID {
        self.data = data
        self.keyPath = \T.id
        self.content = content
    }
}


#Preview {
    SKPage{
        SKForEach<Range<Int>, Int, Any>(0..<10, id: \.self) { item in
            SKTitle("\(item)")
            SKForEach(0..<2, id: \.self) { item in
                SKForEach(0..<2, id: \.self){ item in
                    SKTextField("Text", text: .constant(""))
                }
            }
        }
    }
}
