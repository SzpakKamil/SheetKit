//
//  SKCustomView.swift
//  SheetKit
//
//  Created by Kamil Szpak on 17/08/2025.
//

import SwiftUI

public struct SKCustomView<Content: View>: View, SKComponent {
    public let type: SKComponentType
    let content: Content
    
    public var body: some View {
        content
    }
    
    public init(type: SKComponentType, @ViewBuilder content: () -> Content) {
        self.type = type
        self.content = content()
    }
}
