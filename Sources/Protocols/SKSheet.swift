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
        SKSheetProtocolView(sheet: self)
    }
}


struct SKSheetProtocolView<Sheet: SKSheet>: View{
    @State private var path: [Int] = []
    let sheet: Sheet
    
    var body: some View{
        if let handoffableSheet = sheet as? any SKHandoffableSheet{
            SKSheetView(pages: sheet.pages)
                .skSheetPathBinding($path)
                #if os(macOS)
                .environment(\.skSheetStyle, sheet.style)
                #endif
                .onAppear{
                    path = handoffableSheet.data.path
                }
                .onChange(of: path) { _, newValue in
                    handoffableSheet.data.path = newValue
                }
        }else{
            SKSheetView(pages: sheet.pages)
                #if os(macOS)
                .environment(\.skSheetStyle, sheet.style)
                #endif
        }
    }
    
    init(sheet: Sheet) {
        self.sheet = sheet
        if let handoffableSheet = sheet as? any SKHandoffableSheet{
            print("StartValue: \(handoffableSheet.data.path)")
            self._path = State(initialValue: handoffableSheet.data.path)
        }

    }
}
