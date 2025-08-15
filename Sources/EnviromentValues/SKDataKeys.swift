//
//  SKDataKeys.swift
//  SheetKit
//
//  Created by Kamil Szpak on 15/07/2025.
//

import SwiftUI

private struct SKSheetManagerKey: EnvironmentKey {
    static let defaultValue: SKSheetManager = .init()
}

public extension EnvironmentValues {
    var skSheetManager: SKSheetManager {
        get { self[SKSheetManagerKey.self] }
        set { self[SKSheetManagerKey.self] = newValue }
    }
}


public extension View {
    func skSheetManager(_ manager: SKSheetManager) -> some View {
        ZStack{
            SKSheetDisplayView(index: 0)
            self
        }
        .environment(\.skSheetManager, manager)
    }
}
