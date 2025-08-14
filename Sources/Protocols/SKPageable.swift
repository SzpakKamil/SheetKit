//
//  SKPageable.swift
//  SheetKit
//
//  Created by Kamil Szpak on 14/07/2025.
//

import SwiftUI

public protocol SKPageable: View where Body: View {
    var data: SKPage.Data { get set }
    
    @ViewBuilder @MainActor @preconcurrency var body: Self.Body { get }
    
    
}
public extension SKPageable {
    func erasedContent() -> AnyView {
        AnyView(self)
    }
}

public struct SKCustomPage: View, SKPageable{
    public var data: SKPage.Data
    let content: AnyView
    
    public var body: some View{
        content
    }
    
    public init(data: SKPage.Data, @ViewBuilder content: @escaping () -> some View) {
        self.data = data
        self.content = AnyView(content())
    }
}

