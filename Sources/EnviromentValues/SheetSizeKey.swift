//
//  SheetSizeKey.swift
//  SheetKit
//
//  Created by Kamil Szpak on 15/07/2025.
//

import SwiftUI

private struct SheetSizeKey: EnvironmentKey {
    static let defaultValue: SKSheetSize? = nil
}
extension EnvironmentValues {
    var sheetSize: SKSheetSize? {
        get { self[SheetSizeKey.self] }
        set { self[SheetSizeKey.self] = newValue }
    }
}
