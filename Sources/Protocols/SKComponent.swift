//
//  SKComponent.swift
//  SheetKit
//
//  Created by Kamil Szpak on 14/07/2025.
//

import SwiftUI

public protocol SKComponent: View where Body: View {
    var type: SKComponentType { get }
    
    @ViewBuilder @MainActor @preconcurrency var body: Self.Body { get }
    
    
}
@_documentation(visibility: internal)
public extension SKComponent {
    func erasedContent() -> AnyView {
        AnyView(self)
    }
}


