//
//  SKSheetable.swift
//  SheetKit
//
//  Created by Kamil Szpak on 14/07/2025.
//

import SwiftUI

public protocol SKSheetable: View where Body: View {
    var data: SKSheet.Data { get set }
    
    @ViewBuilder @MainActor @preconcurrency var body: Self.Body { get }
    
    
}
public extension SKSheetable {
    func erasedContent() -> AnyView {
        AnyView(self)
    }
}

public struct SKCustomSheet: View, SKSheetable{
    public var data: SKSheet.Data
    let content: AnyView
    
    public var body: some View{
        content
    }
    
    public init(data: SKSheet.Data, @ViewBuilder content: @escaping () -> some View) {
        self.data = data
        self.content = AnyView(content())
    }
}

