//
//  SKSheetType.swift
//  SheetKit
//
//  Created by Kamil Szpak on 14/07/2025.
//

import SwiftUI

public protocol SKSheet: View{
    #if os(macOS)
    var style: SKSheetStyle { get }
    #endif
    var id: String { get }
    @SKSheetBuilder var pages: [SKPage] { get }
}

public extension SKSheet{
    @ViewBuilder @MainActor @preconcurrency var body: some View{
        SKSheetView(pages: pages)
        #if os(macOS)
            .environment(\.skSheetStyle, self.style)
        #endif
    }
}
