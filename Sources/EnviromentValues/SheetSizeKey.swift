//
//  SheetSizeKey.swift
//  SheetKit
//
//  Created by Kamil Szpak on 15/07/2025.
//

import SwiftUI

private struct SKSheetSizeKey: EnvironmentKey {
    static let defaultValue: SKSheetSize? = nil
}
extension EnvironmentValues {
    var skSheetSize: SKSheetSize? {
        get { self[SKSheetSizeKey.self] }
        set { self[SKSheetSizeKey.self] = newValue }
    }
}
