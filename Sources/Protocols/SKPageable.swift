//
//  SKComponent.swift
//  SheetKit
//
//  Created by Kamil Szpak on 14/07/2025.
//

import SwiftUI

public protocol SKPageable: View where Body: View {
    var data: SKPageableData { get set }
    var adjustedContent: AnyView? { get set}
    @ViewBuilder @MainActor @preconcurrency var body: Self.Body { get }
    
}
@_documentation(visibility: internal)
extension SKPageable {
    func erasedContent() -> AnyView {
        AnyView(self)
    }
}


